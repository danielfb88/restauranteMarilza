CREATE TABLE TB_USUARIO (
	ID SERIAL PRIMARY KEY,
	NOME VARCHAR(100) NOT NULL,
	EMAIL VARCHAR(100) NOT NULL,
	SENHA VARCHAR(100) NOT NULL,
	PERFIL VARCHAR(30) NOT NULL,
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);

CREATE TABLE TB_FORNECEDOR (
	ID SERIAL PRIMARY KEY,
	DESCRICAO VARCHAR(100) NOT NULL,
	OBSERVACAO VARCHAR(200),
	ENDERECO VARCHAR(200) NOT NULL,
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);

CREATE TABLE TB_TELEFONEFORNECEDOR (
	ID SERIAL PRIMARY KEY,
	ID_FORNECEDOR INTEGER NOT NULL,
	DESCRICAO VARCHAR(50) NOT NULL,
	NUMERO NUMERIC(11) NOT NULL,
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);
ALTER TABLE TB_TELEFONEFORNECEDOR ADD CONSTRAINT FK_TELEFONEFORNECEDOR_FORNECEDOR FOREIGN KEY (ID_FORNECEDOR) REFERENCES TB_FORNECEDOR (ID);

CREATE TABLE TB_TAG (
	ID SERIAL PRIMARY KEY,
	DESCRICAO VARCHAR(50) NOT NULL,
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);

CREATE TABLE TB_ITEM (
	ID SERIAL PRIMARY KEY,
	DESCRICAO VARCHAR(100) NOT NULL,
	QTDESTOQUE INTEGER NOT NULL,
	ATIVO BOOLEAN NOT NULL,
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);

CREATE TABLE TB_ITEM_TAG (
	ID SERIAL PRIMARY KEY,
	ID_ITEM INTEGER NOT NULL,
	ID_TAG INTEGER NOT NULL
);
ALTER TABLE TB_ITEM_TAG ADD CONSTRAINT FK_ITEM_TAG_IDITEM FOREIGN KEY (ID_ITEM) REFERENCES TB_ITEM (ID);
ALTER TABLE TB_ITEM_TAG ADD CONSTRAINT FK_ITEM_TAG_IDTAG FOREIGN KEY (ID_TAG) REFERENCES TB_TAG (ID);

CREATE TABLE TB_ITEMFORNECEDOR (
	ID SERIAL PRIMARY KEY,
	ID_ITEM INTEGER NOT NULL,
	ID_FORNECEDOR INTEGER NOT NULL,
	VALORCOMPRA REAL NOT NULL,
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);
ALTER TABLE TB_ITEMFORNECEDOR ADD CONSTRAINT FK_ITEMFORNECEDOR_IDITEM FOREIGN KEY (ID_ITEM) REFERENCES TB_ITEM (ID);
ALTER TABLE TB_ITEMFORNECEDOR ADD CONSTRAINT FK_ITEMFORNECEDOR_IDFORNECEDOR FOREIGN KEY (ID_FORNECEDOR) REFERENCES TB_FORNECEDOR (ID);

CREATE TABLE TB_PRATO (
	ID SERIAL PRIMARY KEY,
	DESCRICAO VARCHAR(100) NOT NULL,
	RECEITA VARCHAR(200),
	OBSERVACAO VARCHAR(200),
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);

CREATE TABLE TB_PRATO_TAG (
	ID SERIAL PRIMARY KEY,
	ID_PRATO INTEGER NOT NULL,
	ID_TAG INTEGER NOT NULL
);
ALTER TABLE TB_PRATO_TAG ADD CONSTRAINT FK_PRATO_TAG_IDPRATO FOREIGN KEY (ID_PRATO) REFERENCES TB_PRATO (ID);
ALTER TABLE TB_PRATO_TAG ADD CONSTRAINT FK_PRATO_TAG_IDTAG FOREIGN KEY (ID_TAG) REFERENCES TB_TAG (ID);

CREATE TABLE TB_PRATO_ITEM (
	ID SERIAL PRIMARY KEY,
	ID_PRATO INTEGER NOT NULL,
	ID_ITEM INTEGER NOT NULL
);
ALTER TABLE TB_PRATO_ITEM ADD CONSTRAINT FK_PRATO_ITEM_IDPRATO FOREIGN KEY (ID_PRATO) REFERENCES TB_PRATO (ID);
ALTER TABLE TB_PRATO_ITEM ADD CONSTRAINT FK_PRATO_ITEM_IDITEM FOREIGN KEY (ID_ITEM) REFERENCES TB_ITEM (ID);

CREATE TABLE TB_OPCAOCARDAPIO (
	ID SERIAL PRIMARY KEY,
	ID_ITEM INTEGER,
	ID_PRATO INTEGER,
	VALORVENDA REAL NOT NULL,
	ATIVO BOOLEAN NOT NULL,
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);
ALTER TABLE TB_OPCAOCARDAPIO ADD CONSTRAINT FK_OPCAOCARDAPIO_IDITEM FOREIGN KEY (ID_ITEM) REFERENCES TB_ITEM (ID);
ALTER TABLE TB_OPCAOCARDAPIO ADD CONSTRAINT FK_OPCAOCARDAPIO_IDPRATO FOREIGN KEY (ID_PRATO) REFERENCES TB_PRATO (ID);

CREATE TABLE TB_MESA (
	ID SERIAL PRIMARY KEY,
	DESCRICAO VARCHAR(30) UNIQUE NOT NULL,
	OBSERVACAO VARCHAR(100),
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);

CREATE TABLE TB_COMANDA (
	ID SERIAL PRIMARY KEY,
	ID_MESA INTEGER NOT NULL,
	OBSERVACAO VARCHAR(100),
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);
ALTER TABLE TB_COMANDA ADD CONSTRAINT FK_COMANDA_MESA FOREIGN KEY (ID_MESA) REFERENCES TB_MESA (ID);

CREATE TABLE TB_PEDIDO (
	ID SERIAL PRIMARY KEY,
	ID_OPCAOCARDAPIO INTEGER NOT NULL,
	ID_COMANDA INTEGER,
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);
ALTER TABLE TB_PEDIDO ADD CONSTRAINT FK_PEDIDO_OPCAOCARDAPIO FOREIGN KEY (ID_OPCAOCARDAPIO) REFERENCES TB_OPCAOCARDAPIO (ID);
ALTER TABLE TB_PEDIDO ADD CONSTRAINT FK_PEDIDO_COMANDA FOREIGN KEY (ID_COMANDA) REFERENCES TB_COMANDA (ID);
