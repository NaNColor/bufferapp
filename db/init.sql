SET default_transaction_read_only = off;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--ALTER ROLE postgres PASSWORD $DB_PASSWORD;
ALTER ROLE postgres PASSWORD '$DB_PASSWORD';
--ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:/PFR+x4aeya0A/5YNH/VLg==$gqG2wrWQRgGGzNPbVy5hPMFcKaVxo+pgJRn0NO6KxUI=:9Mq1zLgjTpc/gLQVpStickNNZBrAxfOZGAimAqisnGU=';
CREATE ROLE repl_user;
ALTER ROLE repl_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:+ohqBlzdOIK141n3agwfZA==$eKuzU/3cy26oOqEdhuX7jD5c6yHkZjExjWDfp3M7KfA=:DEyu/gmsm6zhYhEyK10z4KzE0aTaaW+e+pi58HhODRI=';
ALTER ROLE repl_user PASSWORD '$DB_PASSWORD';

\connect template1

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

\connect postgres

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

CREATE DATABASE pt_db WITH TEMPLATE = template0 ENCODING = 'UTF8' ;--LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';

ALTER DATABASE pt_db OWNER TO postgres;

\connect pt_db

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

CREATE TABLE public.emails (
    id integer NOT NULL,
    email character varying(100) NOT NULL
);

ALTER TABLE public.emails OWNER TO postgres;

CREATE SEQUENCE public.emails_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.emails_id_seq OWNER TO postgres;

ALTER SEQUENCE public.emails_id_seq OWNED BY public.emails.id;

CREATE TABLE public.phones (
    id integer NOT NULL,
    phone character varying(100) NOT NULL
);

ALTER TABLE public.phones OWNER TO postgres;

CREATE SEQUENCE public.phones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.phones_id_seq OWNER TO postgres;
ALTER SEQUENCE public.phones_id_seq OWNED BY public.phones.id;
ALTER TABLE ONLY public.emails ALTER COLUMN id SET DEFAULT nextval('public.emails_id_seq'::regclass);
ALTER TABLE ONLY public.phones ALTER COLUMN id SET DEFAULT nextval('public.phones_id_seq'::regclass);

COPY public.emails (id, email) FROM stdin;
1	email@test.test
2	r.klimov@innopolis.university
\.

COPY public.phones (id, phone) FROM stdin;
1	+7(911) 123-45-67
2	89111234567
\.

SELECT pg_catalog.setval('public.emails_id_seq', 5, true);
SELECT pg_catalog.setval('public.phones_id_seq', 7, true);
ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_pkey PRIMARY KEY (id);