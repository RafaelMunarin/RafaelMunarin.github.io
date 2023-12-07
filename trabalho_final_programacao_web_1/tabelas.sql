-- Table: public.cliente
-- DROP TABLE IF EXISTS public.cliente;

CREATE TABLE IF NOT EXISTS public.cliente
(
    id integer NOT NULL DEFAULT nextval('cliente_id_seq'::regclass),
    nome character varying(255) COLLATE pg_catalog."default",
    sobrenome character varying(255) COLLATE pg_catalog."default",
    data_nascimento date,
    email character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT cliente_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cliente
    OWNER to postgres;


-- Table: public.users
-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    username character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;