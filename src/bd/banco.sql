CREATE DATABASE IF NOT EXISTS MeuCondominio COLLATE utf8mb4_general_ci;

USE MeuCondominio;

CREATE TABLE IF NOT EXISTS CONDOMINIO(
	ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT 'ID único do condomínio',
    CNPJ INT NOT NULL COMMENT 'CNPJ do condomínio',
    Razao_Social VARCHAR(500) NULL COMMENT 'Razão social do condomínio (nome jurídico)',
    Email VARCHAR(100) NOT NULL COMMENT 'Email de acesso do condomínio',
    Senha VARCHAR(50) NOT NULL COMMENT 'Senha de acesso do condomínio'
) COMMENT = 'Tabela do condomínio';

CREATE TABLE IF NOT EXISTS BL_APTO(
	ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT 'ID único do bloco e apartamento',
    CPF_Titular INT NOT NULL COMMENT 'CPF do titular do apartamento',
    Bloco INT NOT NULL COMMENT 'Número do bloco do apartamento',
    Apartamento INT NOT NULL COMMENT 'Número do apartamento',
    CONDOMINIO_ID INT NOT NULL COMMENT 'ID único do condomínio ao qual o apartamento pertence',
    CONSTRAINT FK_BL_APTO_CONDOMINIO
		FOREIGN KEY (CONDOMINIO_ID)
		REFERENCES CONDOMINIO(ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)   COMMENT = 'Tabela de blocos e apartamentos';

CREATE TABLE IF NOT EXISTS ESPACO(
	ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT 'ID único do espaço do condomínio',
    Nome_Espaco VARCHAR(45) NOT NULL COMMENT 'Nome do espaço do condomínio',
    Capacidade INT NOT NULL COMMENT 'Quantidade da capacidade do espaço do condomínio',
    Instrucoes LONGTEXT NULL COMMENT 'Instruções para o espaço do condomínio',
    CONDOMINIO_ID INT NOT NULL COMMENT 'ID único do condomínio ao qual o espaço pertence',
    CONSTRAINT FK_ESPACO_CONDOMINIO
		FOREIGN KEY (CONDOMINIO_ID)
		REFERENCES CONDOMINIO(ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) COMMENT = 'Tabela de espaços do condomínio';

CREATE TABLE IF NOT EXISTS MANUTENCAO(
	ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT 'ID único da manutenção do espaço',
    Tempo_Duracao TIME NOT NULL COMMENT 'Tempo de duração da manutenção',
    Motivo LONGTEXT NOT NULL COMMENT 'Motivo da manutenção',
    ESPACO_ID INT NOT NULL COMMENT 'ID único do espaço que está em manutenção',
    ESPACO_CONDOMINIO_ID INT NOT NULL COMMENT 'ID único do condomínio do espaço que está em manutenção',
    CONSTRAINT FK_MANUTENCAO_ESPACO
		FOREIGN KEY (ESPACO_ID)
		REFERENCES ESPACO(ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_MANUTENCAO_ESPACO_CONDOMINIO
		FOREIGN KEY (ESPACO_CONDOMINIO_ID)
		REFERENCES ESPACO(CONDOMINIO_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) COMMENT = 'Tabela de manutenções dos espaços do condomínio';

CREATE TABLE IF NOT EXISTS CONDOMINOS_TITULAR(
	ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT 'ID único do condômino titular',
    Nome_Titular VARCHAR(100) NOT NULL COMMENT 'Nome do condômino titular',
    CPF_Titular INT NOT NULL COMMENT 'CPF do condômino titular',
    Data_Nasc DATE NOT NULL COMMENT 'Data de nascimento do condômino titular',
    Idade INT NOT NULL COMMENT 'Idade do condômino titular',
    BL_APTO_ID INT NOT NULL COMMENT 'ID único do bloco e apartamento do condômino titular',
    BL_APTO_CONDOMINIO_ID INT NOT NULL COMMENT 'ID único do condomínio do bloco e apartamento',
    CONSTRAINT FK_CONDOMINOS_TITULAR_BL_APTO
		FOREIGN KEY (BL_APTO_ID)
		REFERENCES BL_APTO(ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_CONDOMINOS_TITULAR_BL_APTO_CONDOMINIO
		FOREIGN KEY (BL_APTO_CONDOMINIO_ID)
		REFERENCES BL_APTO(CONDOMINIO_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) COMMENT = 'Tabela de condôminos titulares';

CREATE TABLE IF NOT EXISTS CONDOMINOS_DEPENDENTES(
	ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT 'ID único de dependentes do codômino titular',
    CPF INT NOT NULL COMMENT 'CPF do dependente do condômino titular',
    Nome_Completo VARCHAR(100) NOT NULL COMMENT 'Nome completo do dependente do condômino titular',
    Data_Nasc DATE NOT NULL COMMENT 'Data de nascimento do depentente do condômino titular',
    Idade INT NOT NULL COMMENT 'Idade do dependente do condômino titular',
    CONDOMINOS_TITULAR_ID INT NOT NULL COMMENT 'ID único do condômino titular', 
    CONDOMINOS_TITULAR_BL_APTO_ID INT NOT NULL COMMENT 'ID único do bloco e apartamento do condômino titular', 
    CONDOMINOS_TITULAR_BL_APTO_CONDOMINIO_ID INT NOT NULL COMMENT 'ID único do condomínio do bloco e apartamento do condômino titular',
    CONSTRAINT FK_CONDOMINOS_DEPENDENTES_CONDOMINO_TITULAR
		FOREIGN KEY (CONDOMINOS_TITULAR_ID)
		REFERENCES CONDOMINOS_TITULAR(ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_CONDOMINOS_DEPENDENTES_CONDOMINO_TITULAR_BL_APTO
		FOREIGN KEY (CONDOMINOS_TITULAR_BL_APTO_ID)
		REFERENCES CONDOMINOS_TITULAR(BL_APTO_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_CONDOMINOS_DEPENDENTES_CONDOMINO_TITULAR_BL_APTO_CONDOMINIO
		FOREIGN KEY (CONDOMINOS_TITULAR_BL_APTO_CONDOMINIO_ID)
		REFERENCES CONDOMINOS_TITULAR(BL_APTO_CONDOMINIO_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) COMMENT = 'Tabela dos dependentes dos condôminos titulares';


CREATE TABLE IF NOT EXISTS RESERVAS(
	ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT 'ID da reserva',
    `Data` DATE NOT NULL COMMENT 'Data da reserva',
    Horario TIME NOT NULL COMMENT 'Hora da reserva',
    `Status` VARCHAR(15) COMMENT 'Status da reserva',
    ESPACO_ID INT NOT NULL COMMENT 'ID do espaço da reserva',
    ESPACO_CONDOMINIO_ID INT NOT NULL COMMENT 'ID do condomínio do espaco da reserva',
    CONDOMINOS_ID INT NOT NULL COMMENT 'ID do condômino titular',
    CONSTRAINT FK_RESERVAS_ESPACO
		FOREIGN KEY (ESPACO_ID)
		REFERENCES ESPACO(ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_RESERVAS_ESPACO_CONDOMINIO
		FOREIGN KEY (ESPACO_CONDOMINIO_ID)
		REFERENCES ESPACO(CONDOMINIO_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_RESERVAS_CONDOMINOS
		FOREIGN KEY (CONDOMINOS_ID)
		REFERENCES CONDOMINOS_TITULAR(ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) COMMENT = 'Tabela de reservas de espaços do condomínio';

CREATE TABLE IF NOT EXISTS CONDOMINOS_DEPENDENTES_RESERVAS(
	CONDOMINOS_DEPENDENTES_ID INT NOT NULL COMMENT 'ID do dependente do condômino titular',
    RESERVAS_ID INT NOT NULL COMMENT 'ID da reserva',
    RESERVAS_ESPACO_ID INT NOT NULL COMMENT 'ID do espaço selecionado na reserva',
    RESERVAS_ESPACO_CONDOMINIO_ID INT NOT NULL COMMENT 'ID do condomínio do espaço selecionado na reserva',
    RESERVAS_CONDOMINOS_ID INT NOT NULL COMMENT 'ID do condômino responsável pela reserva',
    CONSTRAINT FK_CONDOMINOS_DEPENDENTES_RESERVAS_CONDOMINOS_DEPENDENTES
		FOREIGN KEY (CONDOMINOS_DEPENDENTES_ID)
		REFERENCES CONDOMINOS_DEPENDENTES(ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_CONDOMINOS_DEPENDENTES_RESERVAS_RESERVAS
		FOREIGN KEY (RESERVAS_ID)
		REFERENCES RESERVAS(ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_CONDOMINOS_DEPENDENTES_RESERVAS_RESERVAS_ESPACO
		FOREIGN KEY (RESERVAS_ESPACO_ID)
		REFERENCES RESERVAS(ESPACO_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_CONDOMINOS_DEPENDENTES_RESERVAS_RESERVAS_ESPACO_CONDOMINIO
		FOREIGN KEY (RESERVAS_ESPACO_CONDOMINIO_ID)
		REFERENCES RESERVAS(ESPACO_CONDOMINIO_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_CONDOMINOS_DEPENDENTES_RESERVAS_CONDOMINOS
		FOREIGN KEY (RESERVAS_CONDOMINOS_ID)
		REFERENCES RESERVAS(CONDOMINOS_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) COMMENT = 'Tabela relacional de dependentes selecionados na reserva';