require('dotenv').config();
const { Client } = require('pg');
const { faker } = require('@faker-js/faker');


const client = new Client({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});


const generateData = () => {
  const usuarios = Array.from({ length: 10 }, () => ({
    nome: faker.name.fullName(),
    email: faker.internet.email(),
    data_registro: faker.date.past(1).toISOString().split('T')[0],
  }));

  const livros = Array.from({ length: 10 }, () => ({
    titulo: faker.lorem.words(3),
    isbn: faker.datatype.uuid().slice(0, 13),
    data_publicacao: faker.date.past(10).toISOString().split('T')[0],
  }));

  const artigos = Array.from({ length: 10 }, () => ({
    titulo: faker.lorem.sentence(5),
    doi: `10.${faker.datatype.number(9999)}/${faker.random.alphaNumeric(8)}`,
    ano_publicacao: faker.date.past(5).getFullYear(),
  }));

  const autores = Array.from({ length: 10 }, () => ({
    nome: faker.name.fullName(),
    nacionalidade: faker.address.country(),
    data_nascimento: faker.date.birthdate({ min: 1930, max: 2000, mode: 'year' }).toISOString().split('T')[0],
  }));

  const categorias = Array.from({ length: 5 }, () => ({
    nome: faker.commerce.department(),
    descricao: faker.lorem.sentence(),
  }));

  return { usuarios, livros, artigos, autores, categorias };
};


const insertData = async () => {
  const { usuarios, livros, artigos, autores, categorias } = generateData();

  try {
    await client.connect();
    console.log('Conectado ao banco de dados!');

    for (const { nome, email, data_registro } of usuarios) {
      await client.query(
        'INSERT INTO Usuario (nome, email, data_registro) VALUES ($1, $2, $3)',
        [nome, email, data_registro]
      );
    }

    for (const { titulo, isbn, data_publicacao } of livros) {
      await client.query(
        'INSERT INTO Livro (titulo, isbn, data_publicacao) VALUES ($1, $2, $3)',
        [titulo, isbn, data_publicacao]
      );
    }

    for (const { titulo, doi, ano_publicacao } of artigos) {
      await client.query(
        'INSERT INTO Artigo (titulo, doi, ano_publicacao) VALUES ($1, $2, $3)',
        [titulo, doi, ano_publicacao]
      );
    }

    for (const { nome, nacionalidade, data_nascimento } of autores) {
      await client.query(
        'INSERT INTO Autor (nome, nacionalidade, data_nascimento) VALUES ($1, $2, $3)',
        [nome, nacionalidade, data_nascimento]
      );
    }

    for (const { nome, descricao } of categorias) {
      await client.query(
        'INSERT INTO Categoria (nome, descricao) VALUES ($1, $2)',
        [nome, descricao]
      );
    }

    console.log('Dados inseridos com sucesso!');
  } catch (error) {
    console.error('Erro ao inserir os dados:', error);
  } finally {
    await client.end();
    console.log('Conexão com o banco de dados encerrada.');
  }
};

insertData();
