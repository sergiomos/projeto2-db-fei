INSERT INTO Usuario (nome, email, data_registro)
VALUES
    ('Ana Silva', 'ana.silva@example.com', '2023-01-15'),
    ('João Oliveira', 'joao.oliveira@example.com', '2023-03-10'),
    ('Carlos Souza', 'carlos.souza@example.com', '2023-05-20'),
    ('Maria Lima', 'maria.lima@example.com', '2023-07-25'),
    ('Fernanda Costa', 'fernanda.costa@example.com', '2023-09-12');

INSERT INTO Livro (titulo, isbn, data_publicacao)
VALUES
    ('O Senhor dos Anéis', '9780544003415', '1954-07-29'),
    ('1984', '9780451524935', '1949-06-08'),
    ('O Código Da Vinci', '9780385504201', '2003-03-18'),
    ('A Revolução dos Bichos', '9780451526342', '1945-08-17'),
    ('Dom Quixote', '9780142437230', '1605-01-16');

INSERT INTO Artigo (titulo, doi, ano_publicacao)
VALUES
    ('Machine Learning in Practice', '10.1007/s00134-020-06050-6', 2020),
    ('Deep Learning for Images', '10.1109/5.771073', 2021),
    ('Blockchain Technology', '10.1145/3132761.3132777', 2019),
    ('AI and Ethics', '10.1145/3173574', 2022),
    ('Quantum Computing Fundamentals', '10.1137/19M1282344', 2018);

INSERT INTO Autor (nome, nacionalidade, data_nascimento)
VALUES
    ('J.R.R. Tolkien', 'Britânica', '1892-01-03'),
    ('George Orwell', 'Britânica', '1903-06-25'),
    ('Dan Brown', 'Americana', '1964-06-22'),
    ('John McCarthy', 'Americana', '1927-09-04'),
    ('Alan Turing', 'Britânica', '1912-06-23');

INSERT INTO Categoria (nome, descricao)
VALUES
    ('Ficção', 'Livros ou artigos com elementos fictícios'),
    ('Tecnologia', 'Artigos relacionados à tecnologia'),
    ('Clássicos', 'Obras consideradas marcos históricos'),
    ('Ciência', 'Conteúdo sobre avanços científicos'),
    ('Ética', 'Tópicos relacionados à moral e ética');

INSERT INTO Anotacao (conteudo, data_criacao, usuario_id)
VALUES
    ('Ótima análise sobre aprendizado de máquina.', '2023-02-10', 1),
    ('Interessante perspectiva ética na IA.', '2023-04-15', 2),
    ('Preciso reler o capítulo sobre blockchain.', '2023-06-20', 3),
    ('Inspiradora narrativa do autor.', '2023-08-05', 4),
    ('Estudo aprofundado sobre computação quântica.', '2023-10-01', 5);
INSERT INTO Autor_Conteudo (autor_id, conteudo_id, tipo)
VALUES
    (1, 1, 'Livro'), -- Tolkien escreveu "O Senhor dos Anéis"
    (2, 2, 'Livro'), -- Orwell escreveu "1984"
    (3, 3, 'Livro'), -- Dan Brown escreveu "O Código Da Vinci"
    (4, 1, 'Artigo'), -- John McCarthy escreveu "Machine Learning in Practice"
    (5, 3, 'Artigo'); -- Alan Turing escreveu "Blockchain Technology"

INSERT INTO Conteudo_Categoria (conteudo_id, categoria_id, tipo, peso)
VALUES
    (1, 1, 'Livro', 9), -- "O Senhor dos Anéis" é Ficção
    (2, 3, 'Livro', 8), -- "1984" é Clássico
    (3, 1, 'Livro', 7), -- "O Código Da Vinci" é Ficção
    (1, 2, 'Artigo', 10), -- "Machine Learning in Practice" é Tecnologia
    (3, 4, 'Artigo', 9); -- "Blockchain Technology" é Ciência
