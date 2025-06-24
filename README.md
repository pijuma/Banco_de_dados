
# Banco de Dados 🗄️💻

Projeto da disciplina SCC0240 - Bases de Dados - Grupo 08


Este projeto visa demonstrar a criação e manipulação de um banco de dados, incluindo a definição de tabelas, inserção de dados, aplicação de restrições, criação de índices e execução de consultas complexas.

[Link Vídeo](https://youtu.be/DLqLwDfJ2VU})

---

## ⚙️ Configuração e Execução

Para configurar e executar o banco de dados e as consultas, siga os passos abaixo na ordem especificada:

1.  **Criação das Tabelas:**
    * Execute o script `create_table.sql` para criar todas as tabelas do banco de dados.

2.  **Inserção dos Dados:**
    * Execute o script `insercoes.sql` para popular as tabelas com os dados iniciais.

3.  **Adição das Chaves Estrangeiras:**
    * Devido à dependência circular entre as tabelas `departamento` e `professor`, as chaves estrangeiras são adicionadas após a criação e população das tabelas. Execute o script `alter_table.sql` para adicionar as restrições de chave estrangeira.

4.  **Criação dos Índices:**
    * Execute o script `index.sql` para criar os índices nas tabelas. Isso otimizará o desempenho das consultas.
    * **Opcional:** Para testar a eficácia dos índices, você pode executar o script `extra_indice.sql` antes desta etapa. Este script popula exaustivamente as tabelas com índices para que a diferença no tempo de execução das consultas seja nítida.

5.  **Execução das Consultas:**
    * Execute o script `query.sql` para realizar as consultas complexas no banco de dados.

6.  **Criação das Views:**
    * Após a execução das consultas, se houver, execute o script `view.sql` para criar as views correspondentes.

---

## 👨‍💻 Alunos

* Matheus Paiva Angarola - **12560982** ([Github](https://github.com/MatheusPaivaa))
* Felipe de Castro Azambuja - **14675437** ([Github](https://github.com/DeguShi))
* Pietra Gullo Salgado Chaves - **14603822** ([Github](https://github.com/pijuma))
* João Pedro Viguini T. T. Correa - **14675503** ([Github](https://github.com/jpviguini))
