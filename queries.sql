-- 1. Liste todos os livros publicados em um determinado ano.
SELECT * 
FROM Livro 
WHERE EXTRACT(YEAR FROM data_publicacao) = 2023;

-- 2. Liste todos os autores que possuem mais de 5 publicações.
SELECT Autor.nome, COUNT(*) AS total_publicacoes
FROM Autor
JOIN Autor_Conteudo ON Autor.autor_id = Autor_Conteudo.autor_id
GROUP BY Autor.autor_id, Autor.nome
HAVING COUNT(*) > 5;

-- 3. Liste os usuários e suas anotações, ordenadas pela data de criação.
SELECT Usuario.nome AS usuario, Anotacao.conteudo AS anotacao, Anotacao.data_criacao
FROM Usuario
JOIN Anotacao ON Usuario.usuario_id = Anotacao.usuario_id
ORDER BY Anotacao.data_criacao DESC;

-- 4. Liste todas as categorias e os títulos de livros/artigos que pertencem a cada categoria.
SELECT Categoria.nome AS categoria, Conteudo_Categoria.tipo, Livro.titulo AS conteudo
FROM Categoria
JOIN Conteudo_Categoria ON Categoria.categoria_id = Conteudo_Categoria.categoria_id
LEFT JOIN Livro ON Conteudo_Categoria.tipo = 'Livro' AND Conteudo_Categoria.conteudo_id = Livro.livro_id
UNION ALL
SELECT Categoria.nome AS categoria, Conteudo_Categoria.tipo, Artigo.titulo AS conteudo
FROM Categoria
JOIN Conteudo_Categoria ON Categoria.categoria_id = Conteudo_Categoria.categoria_id
LEFT JOIN Artigo ON Conteudo_Categoria.tipo = 'Artigo' AND Conteudo_Categoria.conteudo_id = Artigo.artigo_id;

-- 5. Liste as anotações feitas por um usuário específico.
SELECT Anotacao.*
FROM Anotacao
JOIN Usuario ON Anotacao.usuario_id = Usuario.usuario_id
WHERE Usuario.nome = 'Nome do Usuário';

-- 6. Encontre os autores que não possuem publicações registradas.
SELECT Autor.*
FROM Autor
LEFT JOIN Autor_Conteudo ON Autor.autor_id = Autor_Conteudo.autor_id
WHERE Autor_Conteudo.autor_id IS NULL;

-- 7. Liste os livros/artigos em uma categoria específica com peso maior que 5.
SELECT Livro.titulo AS conteudo, Conteudo_Categoria.peso
FROM Conteudo_Categoria
JOIN Livro ON Conteudo_Categoria.tipo = 'Livro' AND Conteudo_Categoria.conteudo_id = Livro.livro_id
WHERE Conteudo_Categoria.categoria_id = 1 AND Conteudo_Categoria.peso > 5
UNION ALL
SELECT Artigo.titulo AS conteudo, Conteudo_Categoria.peso
FROM Conteudo_Categoria
JOIN Artigo ON Conteudo_Categoria.tipo = 'Artigo' AND Conteudo_Categoria.conteudo_id = Artigo.artigo_id
WHERE Conteudo_Categoria.categoria_id = 1 AND Conteudo_Categoria.peso > 5;

-- 8. Liste os títulos de todos os conteúdos (livros/artigos) e seus autores.
SELECT Livro.titulo AS conteudo, Autor.nome AS autor
FROM Autor_Conteudo
JOIN Autor ON Autor_Conteudo.autor_id = Autor.autor_id
JOIN Livro ON Autor_Conteudo.tipo = 'Livro' AND Autor_Conteudo.conteudo_id = Livro.livro_id
UNION ALL
SELECT Artigo.titulo AS conteudo, Autor.nome AS autor
FROM Autor_Conteudo
JOIN Autor ON Autor_Conteudo.autor_id = Autor.autor_id
JOIN Artigo ON Autor_Conteudo.tipo = 'Artigo' AND Autor_Conteudo.conteudo_id = Artigo.artigo_id;

-- 9. Qual é a média de publicações por autor?
SELECT AVG(total_publicacoes) AS media_publicacoes
FROM (
    SELECT COUNT(*) AS total_publicacoes
    FROM Autor_Conteudo
    GROUP BY autor_id
) AS subquery;

-- 10. Liste os usuários que criaram mais de 5 anotações.
SELECT Usuario.nome AS usuario, COUNT(*) AS total_anotacoes
FROM Usuario
JOIN Anotacao ON Usuario.usuario_id = Anotacao.usuario_id
GROUP BY Usuario.usuario_id, Usuario.nome
HAVING COUNT(*) > 5;
