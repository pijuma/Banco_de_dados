--para permitir referencia circular 
ALTER TABLE Professor
ADD CONSTRAINT fk_professor_departamento
FOREIGN KEY (codigo_dept) REFERENCES Departamento(codigo);
