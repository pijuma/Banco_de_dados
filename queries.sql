--1)
--listar todos alunos que se matricularam na disciplina 127 no 2o semestre 
-- de 2025
SELECT M.nome_aluno, M.sobrenome_aluno, M.telefone_aluno
	FROM matriculas AS M
	JOIN Turma AS T ON(M.id_turma=T.id_turma)
	JOIN Disciplina AS D ON(T.codigo_disc=D.codigo_disc)
WHERE (T.semestre = 2 AND T.ano = 2025 AND D.codigo_disc = 127 AND M.status_matricula <> 'Cancelada');

--2)
--calcular media de notas de um aluno numa disciplina 
SELECT M.nome_aluno, M.sobrenome_aluno, M.telefone_aluno, T.codigo_disc, AVG(N.nota) AS Nota_final
	FROM matriculas AS M
	JOIN Turma AS T using(id_turma)
	JOIN Notas_Matricula AS N using(nome_aluno, sobrenome_aluno, telefone_aluno)
	GROUP BY(M.nome_aluno, M.sobrenome_aluno, M.telefone_aluno, T.codigo_disc)


--3)
--listar os professores de um departamento com suas respectivas
--disciplinas num dado semestre
SELECT P.nome, P.sobrenome, P.telefone, T.codigo_disc
	FROM Professor AS P
	JOIN Departamento AS D ON ((D.codigo)=(P.codigo_dept))
	JOIN Turma AS T ON ((P.nome, P.sobrenome, P.telefone)=(T.nome_prof, T.sobrenome_prof, T.telefone_prof))
WHERE (D.codigo = 1 AND T.semestre = 1 AND T.ano = 2025)
--criar indice em semestre_ano de turma pra agilizar a query 

--4)
--listar disciplinas que não tiveram matriculados 
--no ultimo oferecimento 
SELECT D.codigo_disc
	FROM Disciplina AS D 
	JOIN Turma AS T ON D.codigo_disc = T.codigo_disc
	LEFT JOIN Matriculas AS M ON M.id_turma = T.id_turma
	WHERE T.ano = 2025 AND T.semestre = 1 AND NOT EXISTS (
       SELECT 1
       FROM  Matriculas AS M2 
       WHERE  M2.id_turma=T.id_turma 
);

--5)
--Alunos que fizeram alguma disciplina 
--mais de uma vez (em semestres diferentes) com a quantidade
--de vezes que eles fizeram 
SELECT A.nome, A.sobrenome, A.telefone, D.codigo_disc, COUNT(*) AS Vezes_cursada
	FROM Aluno As A
	JOIN Matriculas AS M ON (M.nome_aluno, M.sobrenome_aluno, M.telefone_aluno) = (A.nome, A.sobrenome, A.telefone)
	JOIN Turma T using(id_turma)
	JOIN Disciplina AS D using(codigo_disc)
	GROUP BY (A.nome, A.sobrenome, A.telefone, D.codigo_disc)
	HAVING COUNT(*) > 1;

--6) 
-- listar disciplinas que tiveram mais alunos matriculados
SELECT D.codigo_disc, COUNT(M.id_turma) AS total_matriculas
    FROM Disciplina AS D
    JOIN Turma AS T ON D.codigo_disc = T.codigo_disc
    JOIN Matriculas AS M ON M.id_turma = T.id_turma
    GROUP BY D.codigo_disc, D.codigo_disc
    ORDER BY total_matriculas DESC;

-- 7)
-- listar disciplinas que cada aluno cursou com média acima de 5 (aprovados)
SELECT M.nome_aluno, D.codigo_disc, AVG(N.nota) AS media
	FROM Matriculas AS M
	JOIN Notas_Matricula AS N USING(nome_aluno, sobrenome_aluno, telefone_aluno)
	JOIN Turma AS T ON M.id_turma = T.id_turma
	JOIN Disciplina AS D ON T.codigo_disc = D.codigo_disc
	
	GROUP BY M.nome_aluno, D.codigo_disc
	HAVING AVG(N.nota) >= 5;

