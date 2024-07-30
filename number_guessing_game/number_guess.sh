#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\n~~~~~ NUMBER GUESSING GAME ~~~~~"

echo -e "\nEnter your username:"

ENTER_USERNAME() {
  read USERNAME
  if [[ -z $USERNAME ]]
  then
    echo "Please, enter you username:"
    ENTER_USERNAME
  fi
}

ENTER_USERNAME

# Clean up the username input
USERNAME=$(echo "$USERNAME" | sed -r 's/^ *| *$//g')

USER_DATA=$($PSQL "SELECT users.username, users.user_id, users.games_played, games.guesses FROM users LEFT JOIN games ON users.user_id = games.user_id WHERE username = '$USERNAME' ORDER BY guesses LIMIT 1")
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")

if [ -z $USER_DATA ]
then
  echo "Welcome, $(echo $USERNAME | sed -r 's/^ *| *$//g')! It looks like this is your first time here."
  $PSQL "INSERT INTO users(username) VALUES('$USERNAME')" > /dev/null
  $PSQL "INSERT INTO games(user_id) VALUES($($PSQL "SELECT MAX(user_id) FROM users"))" > /dev/null
else
  echo $USER_DATA | while IFS="|" read USERNAME USER_ID GAMES_PLAYED BEST_GAME
  do
    USER_GAMES=$($PSQL "SELECT MAX(game) as games_played FROM games WHERE user_id = $USER_ID")
    NEW_USER_GAME=$USER_GAMES+1
    $PSQL "INSERT INTO games(user_id, game) VALUES($USER_ID, $NEW_USER_GAME)" > /dev/null
    echo -e "\nWelcome back, $(echo $USERNAME | sed -r 's/^ *| *$//g')! You have played $(echo $GAMES_PLAYED | sed -r 's/^ *| *$//g') games, and your best game took $(echo $BEST_GAME | sed -r 's/^ *| *$//g') guesses."
  done
fi

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")

# PREPARING DATA
USER_GAMES_PLAYED=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE user_id = $USER_ID")
USER_GAMES=$($PSQL "SELECT MAX(game) FROM games WHERE user_id = $USER_ID")
USER_GUESSES=$($PSQL "SELECT MAX(guesses) FROM games WHERE user_id = $USER_ID")

# GENERATING RANDOM NUMBER
SECRET_NUMBER=$(( ( RANDOM % 1000 ) + 1 ))

# RUNNING A GUESSES COUNTER
GUESSES_COUNTER=0

# ASKING FOR A NUMBER
echo "Guess the secret number between 1 and 1000:"

GUESSING_LOOP() {
read USER_NUM
if [[ ! $USER_NUM =~ ^[0-9]+$ ]]
then
  echo -e "\nThat is not an integer, guess again:"
  ((GUESSES_COUNTER++))
  GUESSING_LOOP
else
  if [[ $USER_NUM == $SECRET_NUMBER ]]
  then
      ((GUESSES_COUNTER++))
      $PSQL "UPDATE games SET guesses = $GUESSES_COUNTER WHERE user_id = $USER_ID AND game = $USER_GAMES;" > /dev/null
      echo -e "\nYou guessed it in $(echo $GUESSES_COUNTER | sed -r 's/^ *| *$//g') tries. The secret number was $(echo $SECRET_NUMBER | sed -r 's/^ *| *$//g'). Nice job!"
  else
    if [[ $USER_NUM -gt $SECRET_NUMBER ]]
    then
      ((GUESSES_COUNTER++))
      echo -e "\nIt's lower than that, guess again:"
      GUESSING_LOOP
    elif [[ $USER_NUM -lt $SECRET_NUMBER ]]
    then
      ((GUESSES_COUNTER++))
      echo -e "\nIt's higher than that, guess again:"
      GUESSING_LOOP
    fi
  fi
fi
}

GUESSING_LOOP
