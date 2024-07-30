--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    user_id integer,
    game integer DEFAULT 1 NOT NULL,
    guesses integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer DEFAULT 0
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 1, 5);
INSERT INTO public.games VALUES (1, 2, 3);
INSERT INTO public.games VALUES (1, 3, 1);
INSERT INTO public.games VALUES (2, 1, 400);
INSERT INTO public.games VALUES (2, 2, 217);
INSERT INTO public.games VALUES (3, 1, 660);
INSERT INTO public.games VALUES (3, 2, 823);
INSERT INTO public.games VALUES (2, 3, 443);
INSERT INTO public.games VALUES (2, 4, 251);
INSERT INTO public.games VALUES (2, 5, 575);
INSERT INTO public.games VALUES (1, 4, 1);
INSERT INTO public.games VALUES (4, 1, 294);
INSERT INTO public.games VALUES (4, 2, 925);
INSERT INTO public.games VALUES (5, 1, 107);
INSERT INTO public.games VALUES (5, 2, 682);
INSERT INTO public.games VALUES (4, 3, 10);
INSERT INTO public.games VALUES (4, 4, 41);
INSERT INTO public.games VALUES (4, 5, 973);
INSERT INTO public.games VALUES (6, 1, 269);
INSERT INTO public.games VALUES (6, 2, 450);
INSERT INTO public.games VALUES (7, 1, 228);
INSERT INTO public.games VALUES (7, 2, 679);
INSERT INTO public.games VALUES (6, 3, 13);
INSERT INTO public.games VALUES (6, 4, 494);
INSERT INTO public.games VALUES (6, 5, 199);
INSERT INTO public.games VALUES (8, 1, 535);
INSERT INTO public.games VALUES (8, 2, 309);
INSERT INTO public.games VALUES (9, 1, 286);
INSERT INTO public.games VALUES (9, 2, 374);
INSERT INTO public.games VALUES (8, 3, 565);
INSERT INTO public.games VALUES (8, 4, 968);
INSERT INTO public.games VALUES (8, 5, 651);
INSERT INTO public.games VALUES (10, 1, 270);
INSERT INTO public.games VALUES (10, 2, 828);
INSERT INTO public.games VALUES (11, 1, 188);
INSERT INTO public.games VALUES (11, 2, 501);
INSERT INTO public.games VALUES (10, 3, 940);
INSERT INTO public.games VALUES (10, 4, 161);
INSERT INTO public.games VALUES (10, 5, 964);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (3, 'user_1722348200233', 2);
INSERT INTO public.users VALUES (2, 'user_1722348200234', 5);
INSERT INTO public.users VALUES (1, 'Amaro', 4);
INSERT INTO public.users VALUES (5, 'user_1722348352327', 2);
INSERT INTO public.users VALUES (4, 'user_1722348352328', 5);
INSERT INTO public.users VALUES (7, 'user_1722348359317', 2);
INSERT INTO public.users VALUES (6, 'user_1722348359318', 5);
INSERT INTO public.users VALUES (9, 'user_1722348363752', 2);
INSERT INTO public.users VALUES (8, 'user_1722348363753', 5);
INSERT INTO public.users VALUES (11, 'user_1722348406684', 2);
INSERT INTO public.users VALUES (10, 'user_1722348406685', 5);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 11, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

