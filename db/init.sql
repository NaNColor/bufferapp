CREATE USER repl_user REPLICATION LOGIN PASSWORD 'Qq12345';

CREATE TABLE public.emails (
    id integer NOT NULL,
    email character varying(100) NOT NULL
);

CREATE TABLE public.phones (
    id integer NOT NULL,
    phone character varying(100) NOT NULL
);

INSERT INTO emails (email) VALUES ('email@test.test'), ('r.klimov@innopolis.university');
INSERT INTO phone_numbers (phone_number) VALUES ('+7(911) 123-45-67'), ('89111234567');
