#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

$PSQL "DROP TABLE IF EXISTS users CASCADE;
       DROP TABLE IF EXISTS games CASCADE;"

$PSQL "CREATE TABLE users(
      user_id SERIAL PRIMARY KEY,
      username VARCHAR(22) NOT NULL UNIQUE,
      games_played INT DEFAULT 0
);"

$PSQL "CREATE TABLE games(
      user_id INT,
      FOREIGN KEY(user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,
      game INT NOT NULL DEFAULT 1,
      guesses INT NOT NULL DEFAULT 1
      );"
