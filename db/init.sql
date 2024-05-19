CREATE USER repl_user REPLICATION LOGIN PASSWORD 'Qq12345';

CREATE DATABASE pt_db;

\c pt_db;

CREATE TABLE public.emails (
    id integer NOT NULL,
    email character varying(100) NOT NULL
);

CREATE TABLE public.phones (
    id integer NOT NULL,
    phone character varying(100) NOT NULL
);

COPY public.emails (id, email) FROM stdin;
1	email@test.test
2	r.klimov@innopolis.university
\.

COPY public.phones (id, phone) FROM stdin;
1	+7(911) 123-45-67
2	89111234567
\.