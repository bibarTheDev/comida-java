--
-- PostgreSQL database dump
--

-- Dumped from database version 10.9 (Ubuntu 10.9-0ubuntu0.18.10.1)
-- Dumped by pg_dump version 10.9 (Ubuntu 10.9-0ubuntu0.18.10.1)

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: comida; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comida (
    id integer NOT NULL,
    nome character varying(30),
    peso_volume character varying(10),
    descricao character varying(100)
);


ALTER TABLE public.comida OWNER TO postgres;

--
-- Name: comida_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comida_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comida_id_seq OWNER TO postgres;

--
-- Name: comida_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comida_id_seq OWNED BY public.comida.id;


--
-- Name: ingredientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredientes (
    id integer NOT NULL,
    nome character varying(20)
);


ALTER TABLE public.ingredientes OWNER TO postgres;

--
-- Name: ingredientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ingredientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingredientes_id_seq OWNER TO postgres;

--
-- Name: ingredientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ingredientes_id_seq OWNED BY public.ingredientes.id;


--
-- Name: rel_ingredientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rel_ingredientes (
    comida integer,
    ingr integer
);


ALTER TABLE public.rel_ingredientes OWNER TO postgres;

--
-- Name: comida id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comida ALTER COLUMN id SET DEFAULT nextval('public.comida_id_seq'::regclass);


--
-- Name: ingredientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredientes ALTER COLUMN id SET DEFAULT nextval('public.ingredientes_id_seq'::regclass);


--
-- Data for Name: comida; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comida (id, nome, peso_volume, descricao) FROM stdin;
2	salada elaborada	400g	salada com mais ingredientes que a salada simples, vem com rucula, tomate e cebola adicionais
1	salada top	300g	salada simples porem gostosa de tomate e alface
\.


--
-- Data for Name: ingredientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingredientes (id, nome) FROM stdin;
1	tomate
2	alface
3	cebola
4	pepino
5	rucula
\.


--
-- Data for Name: rel_ingredientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rel_ingredientes (comida, ingr) FROM stdin;
1	1
1	2
2	1
2	2
2	3
2	4
2	5
\.


--
-- Name: comida_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comida_id_seq', 2, true);


--
-- Name: ingredientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingredientes_id_seq', 5, true);


--
-- Name: comida comida_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comida
    ADD CONSTRAINT comida_pkey PRIMARY KEY (id);


--
-- Name: ingredientes ingredientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredientes
    ADD CONSTRAINT ingredientes_pkey PRIMARY KEY (id);


--
-- Name: rel_ingredientes rel_ingredientes_comida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_ingredientes
    ADD CONSTRAINT rel_ingredientes_comida_fkey FOREIGN KEY (comida) REFERENCES public.comida(id);


--
-- Name: rel_ingredientes rel_ingredientes_ingr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rel_ingredientes
    ADD CONSTRAINT rel_ingredientes_ingr_fkey FOREIGN KEY (ingr) REFERENCES public.ingredientes(id);


--
-- PostgreSQL database dump complete
--