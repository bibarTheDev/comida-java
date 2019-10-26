DROP TABLE IF EXISTS rel_ingredientes;
DROP TABLE IF EXISTS ingredientes;
DROP TABLE IF EXISTS comida;

CREATE TABLE comida (
    PRIMARY KEY id serial,
    nome character varying(30),
    peso_volume character varying(10),
    descricao character varying(100)
);

CREATE TABLE ingredientes (
    PRIMARY KEY id serial,
    nome character varying(20) UNIQUE
);

CREATE TABLE rel_ingredientes (
    FOREIGN KEY comida integer REFERENCES comida(id),
    FOREIGN KEY ingr integer REFERENCES ingredientes(id)
);