-- 	Criação das tabelas com os comentários

CREATE TABLE talentos.habilidades (
                habilidade_id NUMERIC NOT NULL,
                nome VARCHAR(255) NOT NULL,
                classe VARCHAR(255) NOT NULL,
                numero_de_praticantes NUMERIC NOT NULL,
                CONSTRAINT habilidades_pk PRIMARY KEY (habilidade_id)
);
COMMENT ON TABLE talentos.habilidades IS 'Tabela das habilidades/talentos dos colaboradors.';
COMMENT ON COLUMN talentos.habilidades.habilidade_id IS 'PK da tabela habilidades.';
COMMENT ON COLUMN talentos.habilidades.nome IS 'Nome da habilidade.';
COMMENT ON COLUMN talentos.habilidades.classe IS 'TIpo da habilidade. Ex.: Esporte, Música, Tech.';
COMMENT ON COLUMN talentos.habilidades.numero_de_praticantes IS 'Quantidade de praticantes de uma habilidade.';


CREATE TABLE talentos.grupos (
                grupo_id NUMERIC NOT NULL,
                nome VARCHAR NOT NULL,
                numero_de_integrantes NUMERIC NOT NULL,
                habilidade_id NUMERIC NOT NULL,
                CONSTRAINT grupos_pk PRIMARY KEY (grupo_id)
);
COMMENT ON COLUMN talentos.grupos.grupo_id IS 'PK da tabela grupos que identifica um grupo.';
COMMENT ON COLUMN talentos.grupos.nome IS 'Nome do grupo.';
COMMENT ON COLUMN talentos.grupos.numero_de_integrantes IS 'Quantidade de praticantes dentro de um grupo.';
COMMENT ON COLUMN talentos.grupos.habilidade_id IS 'PK da tabela habilidades.';


CREATE TABLE talentos.colaboradores (
                colaborador_id NUMERIC NOT NULL,
                nome VARCHAR(50) NOT NULL,
                sobrenome VARCHAR(255) NOT NULL,
                data_de_nascimento DATE NOT NULL,
                email VARCHAR(255) NOT NULL,
                genero VARCHAR(1),
                cargo VARCHAR(255) NOT NULL,
                estado VARCHAR(2) NOT NULL,
                cidade VARCHAR(255) NOT NULL,
                CONSTRAINT colaborares_pk PRIMARY KEY (colaborador_id)
);
COMMENT ON TABLE talentos.colaboradores IS 'Tabela com os dados dos colaboradores da empresa.';
COMMENT ON COLUMN talentos.colaboradores.colaborador_id IS 'PK da tabela colaboradores que identifica um colaborador.';
COMMENT ON COLUMN talentos.colaboradores.nome IS 'Nome do colaborador.';
COMMENT ON COLUMN talentos.colaboradores.sobrenome IS 'Sobrenome do colaborador.';
COMMENT ON COLUMN talentos.colaboradores.data_de_nascimento IS 'Data de nascimento do colaborador.';
COMMENT ON COLUMN talentos.colaboradores.email IS 'Correio eletrônico do colaborador.';
COMMENT ON COLUMN talentos.colaboradores.genero IS 'Gênero do colaborador.';
COMMENT ON COLUMN talentos.colaboradores.cargo IS 'Cargo do colaborador na empresa.';
COMMENT ON COLUMN talentos.colaboradores.estado IS 'Estado onde o colaborador trabalha.';
COMMENT ON COLUMN talentos.colaboradores.cidade IS 'Cidade onde o colaborador trabalha.';


CREATE TABLE talentos.praticantes (
                praticante_id NUMERIC NOT NULL,
                colaborador_id NUMERIC NOT NULL,
                habilidade_id NUMERIC NOT NULL,
                CONSTRAINT praticantes_pk PRIMARY KEY (praticante_id)
);
COMMENT ON TABLE talentos.praticantes IS 'Tabela de pessoas que praticam uma habilidade.';
COMMENT ON COLUMN talentos.praticantes.praticante_id IS 'PK da tabela praticantes.';
COMMENT ON COLUMN talentos.praticantes.colaborador_id IS 'PK da tabela colaboradores que identifica um colaborador.';
COMMENT ON COLUMN talentos.praticantes.habilidade_id IS 'PK da tabela habilidades.';


CREATE TABLE talentos.participantes (
                participante_id NUMERIC NOT NULL,
                colaborador_id NUMERIC NOT NULL,
                grupo_id NUMERIC NOT NULL,
                CONSTRAINT participantes_pk PRIMARY KEY (participante_id)
);
COMMENT ON TABLE talentos.participantes IS 'Tabela de pessoas que participam de um grupo.';
COMMENT ON COLUMN talentos.participantes.participante_id IS 'PK da tabela participantes.';
COMMENT ON COLUMN talentos.participantes.colaborador_id IS 'PK da tabela colaboradores que identifica um colaborador.';
COMMENT ON COLUMN talentos.participantes.grupo_id IS 'PK da tabela grupos que identifica um grupo.';


CREATE TABLE talentos.telefones (
                colaborador_id NUMERIC NOT NULL,
                telefone NUMERIC(50) NOT NULL,
                CONSTRAINT telefones_pk PRIMARY KEY (colaborador_id, telefone)
);
COMMENT ON TABLE talentos.telefones IS 'Telefones de cada colaborador.';
COMMENT ON COLUMN talentos.telefones.colaborador_id IS 'PFK da tabela telefones que identifica o colaborador.';
COMMENT ON COLUMN talentos.telefones.telefone IS 'PK da tabela telefones e que indica o telefone do colaborador.';


ALTER TABLE talentos.grupos ADD CONSTRAINT habilidades_grupos_fk
FOREIGN KEY (habilidade_id)
REFERENCES talentos.habilidades (habilidade_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE talentos.praticantes ADD CONSTRAINT habilidades_praticantes_fk
FOREIGN KEY (habilidade_id)
REFERENCES talentos.habilidades (habilidade_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE talentos.participantes ADD CONSTRAINT grupos_tabela_fk
FOREIGN KEY (grupo_id)
REFERENCES talentos.grupos (grupo_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE talentos.telefones ADD CONSTRAINT colaboradores_telefones_fk
FOREIGN KEY (colaborador_id)
REFERENCES talentos.colaboradores (colaborador_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE talentos.participantes ADD CONSTRAINT colaboradores_tabela_fk
FOREIGN KEY (colaborador_id)
REFERENCES talentos.colaboradores (colaborador_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE talentos.praticantes ADD CONSTRAINT colaboradores_praticantes_fk
FOREIGN KEY (colaborador_id)
REFERENCES talentos.colaboradores (colaborador_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criação das checagens

ALTER TABLE talentos.colaboradores
ADD CONSTRAINT cc_colaboradores_genero
CHECK(
genero in ('M','F')
);

ALTER TABLE talentos.grupos
ADD CONSTRAINT cc_grupos_numero_de_integrantes
CHECK(
numero_de_integrantes >= 0
);

ALTER TABLE talentos.habilidades
ADD CONSTRAINT cc_habilidades_numero_de_praticantes
CHECK(
numero_de_praticantes >= 0
);
