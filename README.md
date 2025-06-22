# Banco_de_dados

Como nós temos uma dependência circula em departamento e professor é necessário cautela para executar os scripts. 
A ordem sugerida e adotada foi a realização da criação de tabelas (arquivo create_table.sql) seguida da inserção das tuplas para população da tabela (insert.sql) e, posteriormente, é necessário a execução do alter table para adicionar a chave estrangeira (alter_table.sql). 

Agora que temos todas tabelas devidamente populadas e com suas devidas restrições podemos criar os índices (index.sql) executar as consultas (query.sql). Ao final da execução de cada consulta podemos criar uma view para a respectiva, caso haja (view.sql). 
