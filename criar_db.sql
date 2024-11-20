
DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE biblioteca;

CREATE TABLE Usuario (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_registro DATE NOT NULL
);

CREATE TABLE Livro (
    livro_id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    data_publicacao DATE NOT NULL
);

CREATE TABLE Artigo (
    artigo_id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    doi VARCHAR(50) UNIQUE NOT NULL,
    ano_publicacao INT NOT NULL
);

CREATE TABLE Autor (
    autor_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50),
    data_nascimento DATE
);

CREATE TABLE Anotacao (
    anotacao_id INT PRIMARY KEY AUTO_INCREMENT,
    conteudo TEXT NOT NULL,
    data_criacao DATE NOT NULL,
    usuario_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id)
);

CREATE TABLE Categoria (
    categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT
);

CREATE TABLE Autor_Conteudo (
    autor_id INT NOT NULL,
    conteudo_id INT NOT NULL,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('Livro', 'Artigo')),
    PRIMARY KEY (autor_id, conteudo_id, tipo),
    FOREIGN KEY (autor_id) REFERENCES Autor(autor_id)
);

CREATE TABLE Conteudo_Categoria (
    conteudo_id INT NOT NULL,
    categoria_id INT NOT NULL,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('Livro', 'Artigo')),
    peso INT DEFAULT 0,
    PRIMARY KEY (conteudo_id, categoria_id, tipo),
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id)
);
