# Biblioteca Digital de Livros e Artigos Científicos

## Integrantes do Grupo

- Sérgio Martins de Oliveira Santos - RA: 22.222.021-2  

## Descrição do Projeto

Este projeto implementa um sistema de gerenciamento para uma biblioteca digital de livros e artigos científicos. Ele permite gerenciar usuários, livros, artigos, categorias, anotações e autores, além de explorar informações úteis por meio de consultas SQL.

## Estrutura do Projeto

O projeto inclui:  
1. **Modelo Entidade-Relacionamento (E-R):** Representa as entidades e relacionamentos do sistema.  
2. **Modelo Relacional:** Normalização das tabelas em 3FN.  
3. **Criação das Tabelas:** Script SQL para criar as tabelas do banco de dados.  
4. **Geração de Dados Aleatórios:** Código em Node.js para gerar dados fictícios e inseri-los no banco de dados.  
5. **Consultas SQL:** 10 consultas úteis para explorar o banco de dados.  

## Tecnologias Utilizadas

- **Banco de Dados:** PostgreSQL  
- **Linguagem:** Node.js  
- **Bibliotecas:** 
  - [`pg`](https://www.npmjs.com/package/pg) para conexão com o PostgreSQL.
  - [`@faker-js/faker`](https://fakerjs.dev/) para gerar dados aleatórios.
  - [`dotenv`](https://www.npmjs.com/package/dotenv) para configurar variáveis de ambiente.

## Configuração do Ambiente

1. **Pré-requisitos:**
   - PostgreSQL instalado.
   - Node.js instalado.

2. **Clonar o repositório:**
   ```bash
   git clone <link-do-repositorio>
   cd biblioteca-digital
   ```

3. **Configurar as variáveis de ambiente:**

Crie um arquivo `.env` na raiz do projeto com o seguinte conteúdo:

   ```env
   PG_HOST=localhost
   PG_PORT=5432
   PG_DATABASE=nome_do_banco
   PG_USER=seu_usuario
   PG_PASSWORD=sua_senha
   ```

4. **Configurar as variáveis de ambiente:**

```bash
  npm install
```
   
5. **Criar as tabelas no banco de dados:**
Execute o script SQL create_tables.sql no seu banco de dados para criar as tabelas.

6. **Gerar e inserir dados aleatórios:**

```bash
  node insertRandomData.js
```
## Modelo Relacional

```mermaid
erDiagram
    USUARIO {
        int id
        string nome
        string email
        date data_registro
    }
    LIVRO {
        int id
        string titulo
        string isbn
        date data_publicacao
    }
    AUTOR {
        int id
        string nome
        string nacionalidade
        date data_nascimento
    }
    CATEGORIA {
        int id
        string nome
        string descricao
    }
    EMPRESTIMO {
        int id
        date data_empréstimo
        date data_devolucao
    }

    LIVRO_AUTOR {
        int livro_id
        int autor_id
        string papel
    }
    
    ARTIGO {
        int id
        string titulo
        string doi
        int ano_publicacao
    }

    ARTIGO_CATEGORIA {
        int artigo_id
        int categoria_id
    }

    USUARIO_LIVRO {
        int usuario_id
        int livro_id
        date data_leitura
    }

    USUARIO_ARTIGO {
        int usuario_id
        int artigo_id
        date data_visualizacao
    }

    USUARIO ||--o{ USUARIO_LIVRO : ""
    USUARIO ||--o{ USUARIO_ARTIGO : ""
    LIVRO ||--o{ USUARIO_LIVRO : ""
    ARTIGO ||--o{ USUARIO_ARTIGO : ""

    LIVRO ||--o{ LIVRO_AUTOR : ""
    AUTOR ||--o{ LIVRO_AUTOR : ""
    ARTIGO ||--o{ ARTIGO_CATEGORIA : ""
    CATEGORIA ||--o{ ARTIGO_CATEGORIA : ""

```

### Tabela: `Usuario`
| Coluna          | Tipo         | Restrição              |
|------------------|--------------|------------------------|
| `id`            | INT       | PRIMARY KEY           |
| `nome`          | VARCHAR(100) | NOT NULL              |
| `email`         | VARCHAR(100) | UNIQUE, NOT NULL      |
| `data_registro` | DATE         | NOT NULL              |

---

### Tabela: `Livro`
| Coluna            | Tipo         | Restrição              |
|--------------------|--------------|------------------------|
| `id`              | INT       | PRIMARY KEY           |
| `titulo`          | VARCHAR(200) | NOT NULL              |
| `isbn`            | VARCHAR(13)  | UNIQUE, NOT NULL      |
| `data_publicacao` | DATE         | NOT NULL              |

---

### Tabela: `Artigo`
| Coluna            | Tipo         | Restrição              |
|--------------------|--------------|------------------------|
| `id`              | INT       | PRIMARY KEY           |
| `titulo`          | VARCHAR(200) | NOT NULL              |
| `doi`             | VARCHAR(50)  | UNIQUE, NOT NULL      |
| `ano_publicacao`  | INT          | NOT NULL              |

---

### Tabela: `Autor`
| Coluna            | Tipo         | Restrição              |
|--------------------|--------------|------------------------|
| `id`              | INT       | PRIMARY KEY           |
| `nome`            | VARCHAR(100) | NOT NULL              |
| `nacionalidade`   | VARCHAR(50)  | NOT NULL              |
| `data_nascimento` | DATE         | NOT NULL              |

---

### Tabela: `Categoria`
| Coluna    | Tipo         | Restrição              |
|-----------|--------------|------------------------|
| `id`      | INT       | PRIMARY KEY           |
| `nome`    | VARCHAR(100) | NOT NULL              |
| `descricao`| TEXT        | NOT NULL              |

---

### Tabela: `LivroAutor` (Relacionamento `n:m` com atributos)
| Coluna      | Tipo         | Restrição              |
|-------------|--------------|------------------------|
| `id`        | INT       | PRIMARY KEY           |
| `livro_id`  | INT          | FOREIGN KEY (`Livro.id`) |
| `autor_id`  | INT          | FOREIGN KEY (`Autor.id`) |
| `papel`     | VARCHAR(50)  | NOT NULL              |

---

### Tabela: `ArtigoCategoria` (Relacionamento `n:m`)
| Coluna          | Tipo         | Restrição              |
|------------------|--------------|------------------------|
| `id`            | INT       | PRIMARY KEY           |
| `artigo_id`     | INT          | FOREIGN KEY (`Artigo.id`) |
| `categoria_id`  | INT          | FOREIGN KEY (`Categoria.id`) |

---

### Tabela: `UsuarioLivro` (Relacionamento entre `Usuario` e `Livro`)
| Coluna        | Tipo         | Restrição              |
|---------------|--------------|------------------------|
| `id`          | INT       | PRIMARY KEY           |
| `usuario_id`  | INT          | FOREIGN KEY (`Usuario.id`) |
| `livro_id`    | INT          | FOREIGN KEY (`Livro.id`) |
| `data_leitura`| DATE         | NOT NULL              |

---

### Tabela: `UsuarioArtigo` (Relacionamento entre `Usuario` e `Artigo`)
| Coluna        | Tipo         | Restrição              |
|---------------|--------------|------------------------|
| `id`          | INT       | PRIMARY KEY           |
| `usuario_id`  | INT          | FOREIGN KEY (`Usuario.id`) |
| `artigo_id`   | INT          | FOREIGN KEY (`Artigo.id`) |
| `data_visualizacao` | DATE   | NOT NULL              |


## Modelo de Entidade-Relacionamento

```mermaid
erDiagram
    Usuario {
        INT usuario_id PK
        VARCHAR nome
        VARCHAR email
        DATE data_registro
    }
    Livro {
        INT livro_id PK
        VARCHAR titulo
        VARCHAR isbn
        DATE data_publicacao
    }
    Artigo {
        INT artigo_id PK
        VARCHAR titulo
        VARCHAR doi
        INT ano_publicacao
    }
    Autor {
        INT autor_id PK
        VARCHAR nome
        VARCHAR nacionalidade
        DATE data_nascimento
    }
    Categoria {
        INT categoria_id PK
        VARCHAR nome
        TEXT descricao
    }
    Anotacao {
        INT anotacao_id PK
        TEXT conteudo
        DATE data_criacao
        INT usuario_id FK
    }
    Autor_Conteudo {
        INT autor_id FK
        INT conteudo_id FK
        VARCHAR tipo
    }
    Conteudo_Categoria {
        INT conteudo_id FK
        INT categoria_id FK
        VARCHAR tipo
        INT peso
    }
    
    Usuario ||--o{ Anotacao : "cria"
    Livro ||--o{ Autor_Conteudo : "tem"
    Artigo ||--o{ Autor_Conteudo : "tem"
    Autor ||--o{ Autor_Conteudo : "escreve"
    Livro ||--o{ Conteudo_Categoria : "classificado"
    Artigo ||--o{ Conteudo_Categoria : "classificado"
    Categoria ||--o{ Conteudo_Categoria : "inclui"

```
