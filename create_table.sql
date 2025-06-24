CREATE TABLE Usuario( 
	nome varchar(40),
	sobrenome varchar(100), 
	telefone text CHECK (telefone ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	dia_nascimento int, 
	mes_nascimento int, 
	ano_nascimento int, 
	cidade varchar(50), 
	estado varchar(50), 
	pais varchar(500),
	complemento varchar(500),
	email text CHECK(email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') NOT NULL,
	senha_acesso text NOT NULL, 
	sexo varchar(20), 
	vinculo varchar(20) NOT NULL,
	UNIQUE(email, senha_acesso),
	PRIMARY KEY(nome, sobrenome, telefone) 
);

CREATE TABLE Unidade(
	id_unidade int PRIMARY KEY, 
	cidade varchar(50), 
	estado varchar(50), 
	pais varchar(500)
);

CREATE TABLE Blocos_Unidade(
	id_unidade int,
	bloco int,
	PRIMARY KEY (id_unidade, bloco),
	FOREIGN KEY (id_unidade) REFERENCES Unidade(id_unidade)
);

CREATE TABLE Aluno(
	nome varchar(40),
	sobrenome varchar(100), 
	telefone text CHECK (telefone ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	id_unidade int NOT NULL, 
	PRIMARY KEY(nome, sobrenome, telefone),
	FOREIGN KEY (id_unidade) REFERENCES Unidade(id_unidade),
	FOREIGN KEY (nome, sobrenome, telefone) REFERENCES Usuario(nome, sobrenome, telefone)
);

CREATE TABLE Administrador(
	nome varchar(40),
	sobrenome varchar(100), 
	telefone text CHECK (telefone ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	FOREIGN KEY (nome, sobrenome, telefone) REFERENCES Usuario(nome, sobrenome, telefone),
	PRIMARY KEY (nome, sobrenome, telefone) 
);

CREATE TABLE Sala(
	num_sala int, 
	max_alunos int, 
	bloco_sala int NOT NULL, --veio do relacionamento - derivado (aplicação lida)
	id_unidade int NOT NULL, 
	FOREIGN KEY (id_unidade) REFERENCES Unidade(id_unidade),
	PRIMARY KEY(num_sala)
);

CREATE TABLE Professor(
	nome varchar(40),
	sobrenome varchar(100), 
	telefone text CHECK (telefone ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	area_especializacao text, 
	titulacao text,
	num_sala int NOT NULL,
	codigo_dept int NOT NULL,
	FOREIGN KEY (nome, sobrenome, telefone) REFERENCES Usuario(nome, sobrenome, telefone),
	PRIMARY KEY (nome, sobrenome, telefone), 
	FOREIGN KEY (num_sala) REFERENCES Sala(num_sala)
);

CREATE TABLE Avisos_gerais(
	id_aviso int PRIMARY KEY, 
	texto text, 
	nome_adm varchar(40) NOT NULL,
	sobrenome_adm varchar(100) NOT NULL, 
	telefone_adm text CHECK (telefone_adm ~ '^\(\d{2}\) \d{4,5}-\d{4}$') NOT NULL,
	FOREIGN KEY (nome_adm, sobrenome_adm, telefone_adm) REFERENCES Administrador(nome, sobrenome, telefone)
);

CREATE TABLE Infraestrutura(
	id_estrutura int PRIMARY KEY, 
	descricao text
);

CREATE TABLE Disciplina(
	codigo_disc int PRIMARY KEY, 
	qtd_aulas_semana int,
	material text
);

CREATE TABLE chat_direto(
	id_msg int PRIMARY KEY, 
	nome_remetente varchar(40), 
	sobrenome_remetente varchar(100), 
	telefone_remetente text CHECK (telefone_remetente ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	nome_destinatario varchar(40), 
	sobrenome_destinatario varchar(100), 
	telefone_destinatario text CHECK (telefone_destinatario ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	timestamp TIMESTAMP, 
	texto text, 
	UNIQUE(nome_remetente, sobrenome_remetente, telefone_remetente, 
	nome_destinatario, sobrenome_destinatario, telefone_destinatario,timestamp),
	FOREIGN KEY (nome_remetente, sobrenome_remetente, telefone_remetente) REFERENCES Usuario(nome, sobrenome, telefone), 
	FOREIGN KEY (nome_destinatario, sobrenome_destinatario, telefone_destinatario) REFERENCES Usuario(nome, sobrenome, telefone)
);

CREATE TABLE Turma(
	id_turma int PRIMARY KEY, 
	semestre int CHECK(semestre BETWEEN 1 AND 2), 
    ano int, 
	nome_prof varchar(40), 
	sobrenome_prof varchar(100),
	telefone_prof text CHECK (telefone_prof ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	codigo_disc int REFERENCES Disciplina(codigo_disc),
	qtd_alunos int, 
	UNIQUE(semestre, ano, nome_prof, sobrenome_prof, telefone_prof, codigo_disc), 
	FOREIGN KEY (nome_prof, sobrenome_prof, telefone_prof) REFERENCES Usuario(nome, sobrenome,telefone)
);

CREATE TABLE Matriculas(
	nome_aluno varchar(40), 
	sobrenome_aluno varchar(100), 
	telefone_aluno text CHECK (telefone_aluno ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	id_turma int, 
	dia_matricula int NOT NULL, 
	mes_matricula int NOT NULL, 
	ano_matricula int NOT NULL, 
	status_matricula VARCHAR(10) NOT NULL CHECK (status_matricula IN ('Ativa', 'Inativa', 'Pendente', 'Cancelada')),
	dia_mudanca int, 
	mes_mudanca int, 
	ano_mudanca int, 
	taxa int,
	PRIMARY KEY(nome_aluno, sobrenome_aluno, telefone_aluno, id_turma), 
	FOREIGN KEY (nome_aluno, sobrenome_aluno, telefone_aluno) REFERENCES Aluno(nome, sobrenome, telefone), 
	FOREIGN KEY (id_turma) REFERENCES Turma(id_turma)
);

CREATE TABLE chat_turma(
	id_msg int PRIMARY KEY, 
	nome_prof varchar(40),
	sobrenome_prof varchar(100), 
	telefone_prof text CHECK (telefone_prof ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	id_turma int REFERENCES Turma(id_turma), 
	timestamp TIMESTAMP, 
	texto text, 
	UNIQUE(nome_prof, sobrenome_prof, telefone_prof, id_turma, timestamp), 
	FOREIGN KEY (nome_prof, sobrenome_prof, telefone_prof) REFERENCES Professor(nome, sobrenome, telefone)
);

CREATE TABLE Departamento(
	codigo int PRIMARY KEY, 
	nome_dept varchar(40), 
	nome varchar(40) NOT NULL,
	sobrenome varchar(100) NOT NULL, 
	telefone text CHECK (telefone ~ '^\(\d{2}\) \d{4,5}-\d{4}$') NOT NULL,
	FOREIGN KEY (nome, sobrenome, telefone) REFERENCES Professor(nome, sobrenome, telefone)
);

CREATE TABLE Curso(
	codigo_unico int PRIMARY KEY, 
	nivel VARCHAR(12) NOT NULL CHECK (nivel IN ('Fundamental', 'Técnico', 'Graduação', 'Médio')),
	carga_horaria int, 
	numero_vagas int, 
	codigo_dept int NOT NULL REFERENCES Departamento(codigo), 
	id_unidade int NOT NULL REFERENCES Unidade(id_unidade)
);

CREATE TABLE Curso_pre_disc(
	codigo_unico_curso int REFERENCES Curso(codigo_unico),
	codigo_disc int REFERENCES Disciplina(codigo_disc),
	PRIMARY KEY(codigo_unico_curso, codigo_disc)
);

CREATE TABLE Composicao_curso(
	codigo_unico_curso int REFERENCES Curso(codigo_unico),
	codigo_disc int REFERENCES Disciplina(codigo_disc),
	PRIMARY KEY(codigo_unico_curso, codigo_disc)
);

CREATE TABLE Agendamento_salas(
	id_turma int REFERENCES Turma(id_turma), 
	num_sala int REFERENCES Sala(num_sala),
	PRIMARY KEY(id_turma, num_sala)
);

CREATE TABLE Responsaveis_disc(
	nome varchar(40),
	sobrenome varchar(100), 
	telefone text CHECK (telefone ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	codigo_disc int REFERENCES Disciplina(codigo_disc),
	PRIMARY KEY(nome, sobrenome, telefone, codigo_disc)
);

CREATE TABLE Infras_sala(
	num_sala int REFERENCES Sala(num_sala), 
	id_estrutura int REFERENCES Infraestrutura(id_estrutura),
	PRIMARY KEY(num_sala, id_estrutura)
);

CREATE TABLE Necessidade_curso(
	id_estrutura int REFERENCES Infraestrutura(id_estrutura),
	codigo_unico int REFERENCES Curso(codigo_unico), 
	PRIMARY KEY(id_estrutura, codigo_unico)
);

CREATE TABLE Regras_Curso(
	codigo_unico_curso int REFERENCES Curso(codigo_unico),
	regra text, 
	PRIMARY KEY(codigo_unico_curso, regra) 
);

CREATE TABLE Nomes_Curso(
	codigo_unico_curso int REFERENCES Curso(codigo_unico),
	nome varchar(100), 
	PRIMARY KEY(nome, codigo_unico_curso)
);
CREATE TABLE Avaliacao_Matricula(
	nome_aluno varchar(40),
	sobrenome_aluno varchar(100), 
	telefone_aluno text CHECK (telefone_aluno ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	id_turma int, 
	comentario text, 
	classificacao_didatica INT CHECK (classificacao_didatica BETWEEN 0 AND 5),
	material_apoio text, 
	relevancia_conteudo INT CHECK (relevancia_conteudo BETWEEN 0 AND 5), 
	infraestrutura_sala INT CHECK (infraestrutura_sala BETWEEN 0 AND 5),
	PRIMARY KEY(nome_aluno, sobrenome_aluno, telefone_aluno, id_turma),
	FOREIGN KEY (nome_aluno, sobrenome_aluno, telefone_aluno, id_turma) REFERENCES Matriculas(nome_aluno, 
	sobrenome_aluno, telefone_aluno, id_turma)
);

CREATE TABLE Notas_Matricula(
	nome_aluno varchar(40),
	sobrenome_aluno varchar(100), 
	telefone_aluno text CHECK (telefone_aluno ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	id_turma int, 
	nota int,
	PRIMARY KEY(nome_aluno, sobrenome_aluno, telefone_aluno, id_turma, nota),
	FOREIGN KEY (nome_aluno, sobrenome_aluno, telefone_aluno, id_turma) REFERENCES Matriculas(nome_aluno, 
	sobrenome_aluno, telefone_aluno, id_turma)
);

CREATE TABLE Bolsas_Estudo_Matricula(
	nome_aluno varchar(40),
	sobrenome_aluno varchar(100), 
	telefone_aluno text CHECK (telefone_aluno ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	id_turma int, 
	bolsa text,
	PRIMARY KEY(nome_aluno, sobrenome_aluno, telefone_aluno, id_turma, bolsa),
	FOREIGN KEY (nome_aluno, sobrenome_aluno, telefone_aluno, id_turma) REFERENCES Matriculas(nome_aluno, 
	sobrenome_aluno, telefone_aluno, id_turma)
);


CREATE TABLE Descontos_Matricula(
	nome_aluno varchar(40),
	sobrenome_aluno varchar(100), 
	telefone_aluno text CHECK (telefone_aluno ~ '^\(\d{2}\) \d{4,5}-\d{4}$'),
	id_turma int, 
	desconto int,
	PRIMARY KEY(nome_aluno, sobrenome_aluno, telefone_aluno, id_turma, desconto),
	FOREIGN KEY (nome_aluno, sobrenome_aluno, telefone_aluno, id_turma) REFERENCES Matriculas(nome_aluno, 
	sobrenome_aluno, telefone_aluno, id_turma)
);

CREATE TABLE Horario(
    dia_semana int CHECK(dia_semana BETWEEN 1 AND 7), 
    hora_ini TIMESTAMP, 
    id_turma int REFERENCES Turma(id_turma), 
    num_sala int REFERENCES Sala(num_sala), 
    hora_fim TIMESTAMP, 
    PRIMARY KEY (dia_semana, hora_ini, id_turma)
);
