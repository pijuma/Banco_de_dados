CREATE INDEX periodo_letivo ON Turma USING btree (semestre, ano);
CREATE INDEX disc_turma ON Turma USING btree (codigo_disc);
CREATE INDEX turma_mat ON Matriculas USING btree (id_turma);
