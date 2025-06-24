DO $$
DECLARE
  target_count   INTEGER := 150000;       
  inserted_count INTEGER := 0;             
  v_sem          INTEGER;
  v_ano          INTEGER;
  v_id           INTEGER;
  v_nome         VARCHAR(40);
  v_sobrenome    VARCHAR(100);
  v_telefone     TEXT;
  v_codigo_disc  INTEGER;
  v_qtd_alunos   INTEGER;
  max_id         INTEGER;
BEGIN
  
  SELECT COALESCE(MAX(id_turma),0) INTO max_id FROM Turma;

  WHILE inserted_count < target_count LOOP
    
    v_sem := (1 + floor(random() * 2))::int;                    
    v_ano := (2000 + floor(random() * 26))::int;                
    v_qtd_alunos := (1 + floor(random() * 100))::int;           

    SELECT p.nome, p.sobrenome, p.telefone
      INTO v_nome, v_sobrenome, v_telefone
    FROM Professor p
    ORDER BY random()
    LIMIT 1;


    SELECT d.codigo_disc
      INTO v_codigo_disc
    FROM Disciplina d
    ORDER BY random()
    LIMIT 1;

    max_id := max_id + 1;

    BEGIN
      INSERT INTO Turma (
        id_turma,
        semestre,
        ano,
        nome_prof,
        sobrenome_prof,
        telefone_prof,
        codigo_disc,
        qtd_alunos
      ) VALUES (
        max_id,
        v_sem,
        v_ano,
        v_nome,
        v_sobrenome,
        v_telefone,
        v_codigo_disc,
        v_qtd_alunos
      );

      inserted_count := inserted_count + 1;

    EXCEPTION -- se violou alguma restrição, ignora a tupla gerada
      WHEN unique_violation THEN
        NULL;
    END;
  END LOOP;

  RAISE NOTICE 'Inseridas % tuplas em Turma', inserted_count;
END
$$;

/*
2o script
*/

WITH
  cnt_al AS (
    SELECT COUNT(*) AS cnt_al
    FROM Aluno
  ),
  cnt_tu AS (
    SELECT COUNT(*) AS cnt_tu
    FROM Turma
  ),
  alunos AS (
    SELECT
      ROW_NUMBER() OVER () AS rn,
      nome,
      sobrenome,
      telefone
    FROM Aluno
  ),
  turmas AS (
    SELECT
      ROW_NUMBER() OVER () AS rn,
      id_turma
    FROM Turma
  ),
  seq AS (
    SELECT generate_series(1, 150000) AS gs
  ),
  combos AS (
    SELECT
      ((gs - 1) % cnt_al.cnt_al) + 1                             AS idx_aluno,
      (((gs - 1) / cnt_al.cnt_al) % cnt_tu.cnt_tu) + 1           AS idx_turma
    FROM seq
    CROSS JOIN cnt_al
    CROSS JOIN cnt_tu
  )
INSERT INTO Matriculas (
  nome_aluno,
  sobrenome_aluno,
  telefone_aluno,
  id_turma,
  dia_matricula,
  mes_matricula,
  ano_matricula,
  status_matricula,
  dia_mudanca,
  mes_mudanca,
  ano_mudanca,
  taxa
)
SELECT
  a.nome,
  a.sobrenome,
  a.telefone,
  t.id_turma,
  (floor(random() * 28) + 1)::int,                                                  
  (floor(random() * 12) + 1)::int,                                                  
  (floor(random() * 26) + 2000)::int,                                                
  (array['Ativa','Inativa','Pendente','Cancelada'])[(floor(random() * 4) + 1)::int],
  CASE WHEN random() < 0.5 THEN NULL ELSE (floor(random() * 28) + 1)::int END,       
  CASE WHEN random() < 0.5 THEN NULL ELSE (floor(random() * 12) + 1)::int END,        
  CASE WHEN random() < 0.5 THEN NULL ELSE (floor(random() * 26) + 2000)::int END,      
  (floor(random() * 1000))::int                                                      
FROM combos c
JOIN alunos a ON a.rn = c.idx_aluno
JOIN turmas t ON t.rn = c.idx_turma
ON CONFLICT (nome_aluno, sobrenome_aluno, telefone_aluno, id_turma) DO NOTHING;

  (FLOOR(RANDOM() * 1000))::int AS taxa
FROM combos c
JOIN alunos a ON a.rn = c.idx_aluno
JOIN turmas t ON t.rn = c.idx_turma;

