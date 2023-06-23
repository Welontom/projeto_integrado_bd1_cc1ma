-- 	Criação das tabelas com os comentários

CREATE TABLE habilidades (
                habilidade_id NUMERIC NOT NULL,
                nome VARCHAR(255) NOT NULL,
                classe VARCHAR(255) NOT NULL,
                numero_de_praticantes NUMERIC NOT NULL,
                CONSTRAINT habilidades_pk PRIMARY KEY (habilidade_id)
);
COMMENT ON TABLE habilidades IS 'Tabela das habilidades/talentos dos colaboradors.';
COMMENT ON COLUMN habilidades.habilidade_id IS 'PK da tabela habilidades.';
COMMENT ON COLUMN habilidades.nome IS 'Nome da habilidade.';
COMMENT ON COLUMN habilidades.classe IS 'TIpo da habilidade. Ex.: Esporte, Música, Tech.';
COMMENT ON COLUMN habilidades.numero_de_praticantes IS 'Quantidade de praticantes de uma habilidade.';


CREATE TABLE grupos (
                grupo_id NUMERIC NOT NULL,
                nome VARCHAR NOT NULL,
                numero_de_integrantes NUMERIC NOT NULL,
                habilidade_id NUMERIC NOT NULL,
                CONSTRAINT grupos_pk PRIMARY KEY (grupo_id)
);
COMMENT ON TABLE grupos IS 'Tabela com os dados dos grupos da empresa.';
COMMENT ON COLUMN grupos.grupo_id IS 'PK da tabela grupos que identifica um grupo.';
COMMENT ON COLUMN grupos.nome IS 'Nome do grupo.';
COMMENT ON COLUMN grupos.numero_de_integrantes IS 'Quantidade de praticantes dentro de um grupo.';
COMMENT ON COLUMN grupos.habilidade_id IS 'FK da tabela grupos.';


CREATE TABLE colaboradores (
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
COMMENT ON TABLE colaboradores IS 'Tabela com os dados dos colaboradores da empresa.';
COMMENT ON COLUMN colaboradores.colaborador_id IS 'PK da tabela colaboradores que identifica um colaborador.';
COMMENT ON COLUMN colaboradores.nome IS 'Nome do colaborador.';
COMMENT ON COLUMN colaboradores.sobrenome IS 'Sobrenome do colaborador.';
COMMENT ON COLUMN colaboradores.data_de_nascimento IS 'Data de nascimento do colaborador.';
COMMENT ON COLUMN colaboradores.email IS 'Correio eletrônico do colaborador.';
COMMENT ON COLUMN colaboradores.genero IS 'Gênero do colaborador.';
COMMENT ON COLUMN colaboradores.cargo IS 'Cargo do colaborador na empresa.';
COMMENT ON COLUMN colaboradores.estado IS 'Estado onde o colaborador trabalha.';
COMMENT ON COLUMN colaboradores.cidade IS 'Cidade onde o colaborador trabalha.';


CREATE TABLE praticantes (
                praticante_id NUMERIC NOT NULL,
                colaborador_id NUMERIC NOT NULL,
                habilidade_id NUMERIC NOT NULL,
                CONSTRAINT praticantes_pk PRIMARY KEY (praticante_id)
);
COMMENT ON TABLE praticantes IS 'Tabela de pessoas que praticam uma habilidade.';
COMMENT ON COLUMN praticantes.praticante_id IS 'PK da tabela praticantes.';
COMMENT ON COLUMN praticantes.colaborador_id IS 'FK da tabela praticantes que identifica um colaborador.';
COMMENT ON COLUMN praticantes.habilidade_id IS 'FK da tabela praticantes.';


CREATE TABLE participantes (
                participante_id NUMERIC NOT NULL,
                colaborador_id NUMERIC NOT NULL,
                grupo_id NUMERIC NOT NULL,
                CONSTRAINT participantes_pk PRIMARY KEY (participante_id)
);
COMMENT ON TABLE participantes IS 'Tabela de pessoas que participam de um grupo.';
COMMENT ON COLUMN participantes.participante_id IS 'PK da tabela participantes.';
COMMENT ON COLUMN participantes.colaborador_id IS 'FK da tabela participantes que identifica um colaborador.';
COMMENT ON COLUMN participantes.grupo_id IS 'FK da tabela participantes que identifica um grupo.';


CREATE TABLE telefones (
                colaborador_id NUMERIC NOT NULL,
                telefone NUMERIC(50) NOT NULL,
                CONSTRAINT telefones_pk PRIMARY KEY (colaborador_id, telefone)
);
COMMENT ON TABLE telefones IS 'Telefones de cada colaborador.';
COMMENT ON COLUMN telefones.colaborador_id IS 'PFK da tabela telefones que identifica o colaborador.';
COMMENT ON COLUMN telefones.telefone IS 'PK da tabela telefones e que indica o telefone do colaborador.';

-- Criação dos relacionamnetos entre as tabelas

ALTER TABLE grupos ADD CONSTRAINT habilidades_grupos_fk
FOREIGN KEY (habilidade_id)
REFERENCES habilidades (habilidade_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE praticantes ADD CONSTRAINT habilidades_praticantes_fk
FOREIGN KEY (habilidade_id)
REFERENCES habilidades (habilidade_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE participantes ADD CONSTRAINT grupos_tabela_fk
FOREIGN KEY (grupo_id)
REFERENCES grupos (grupo_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE telefones ADD CONSTRAINT colaboradores_telefones_fk
FOREIGN KEY (colaborador_id)
REFERENCES colaboradores (colaborador_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE participantes ADD CONSTRAINT colaboradores_tabela_fk
FOREIGN KEY (colaborador_id)
REFERENCES colaboradores (colaborador_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE praticantes ADD CONSTRAINT colaboradores_praticantes_fk
FOREIGN KEY (colaborador_id)
REFERENCES colaboradores (colaborador_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criação das checagens

ALTER TABLE colaboradores
ADD CONSTRAINT cc_colaboradores_genero
CHECK(
genero in ('M','F')
);

ALTER TABLE grupos
ADD CONSTRAINT cc_grupos_numero_de_integrantes
CHECK(
numero_de_integrantes >= 0
);

ALTER TABLE habilidades
ADD CONSTRAINT cc_habilidades_numero_de_praticantes
CHECK(
numero_de_praticantes >= 0
);

