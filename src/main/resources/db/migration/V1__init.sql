﻿CREATE TABLE TB_FORNECEDOR (
	ID_FORNECEDOR SERIAL PRIMARY KEY,
	DESCRICAO VARCHAR(50) NOT NULL,
	OBSERVACAO VARCHAR(200),
	ENDERECO VARCHAR NOT NULL
);

CREATE TABLE TB_TELEFONEFORNECEDOR (
	ID_TELEFONE SERIAL PRIMARY KEY,
	ID_FORNECEDOR INTEGER NOT NULL,
	DESCRICAO VARCHAR(50) NOT NULL,
	NUMERO NUMERIC(11) NOT NULL
);
ALTER TABLE TB_TELEFONEFORNECEDOR ADD CONSTRAINT FK_TELEFONEFORNECEDOR_FORNECEDOR FOREIGN KEY (ID_FORNECEDOR) REFERENCES TB_FORNECEDOR (ID_FORNECEDOR);

CREATE TABLE TB_TAG (
	ID_TAG SERIAL PRIMARY KEY,
	DESCRICAO VARCHAR(50) NOT NULL
);

CREATE TABLE TB_ITEM (
	ID_ITEM SERIAL PRIMARY KEY,
	DESCRICAO VARCHAR(100) NOT NULL,
	QTDESTOQUE INTEGER NOT NULL,
	ATIVO BOOLEAN NOT NULL
);

CREATE TABLE TB_ITEM_TAG (
	ID_ITEM_TAG SERIAL PRIMARY KEY,
	ID_ITEM INTEGER NOT NULL,
	ID_TAG INTEGER NOT NULL
);
ALTER TABLE TB_ITEM_TAG ADD CONSTRAINT FK_ITEM_TAG_IDITEM FOREIGN KEY (ID_ITEM) REFERENCES TB_ITEM (ID_ITEM);
ALTER TABLE TB_ITEM_TAG ADD CONSTRAINT FK_ITEM_TAG_IDTAG FOREIGN KEY (ID_TAG) REFERENCES TB_TAG (ID_TAG);

CREATE TABLE TB_ITEMFORNECEDOR (
	ID_ITEM_FORNECEDOR SERIAL PRIMARY KEY,
	ID_ITEM INTEGER NOT NULL,
	ID_FORNECEDOR INTEGER NOT NULL,
	VALORCOMPRA REAL NOT NULL,
	DATAHORA TIMESTAMP NOT NULL
);
ALTER TABLE TB_ITEMFORNECEDOR ADD CONSTRAINT FK_ITEMFORNECEDOR_IDITEM FOREIGN KEY (ID_ITEM) REFERENCES TB_ITEM (ID_ITEM);
ALTER TABLE TB_ITEMFORNECEDOR ADD CONSTRAINT FK_ITEMFORNECEDOR_IDFORNECEDOR FOREIGN KEY (ID_FORNECEDOR) REFERENCES TB_FORNECEDOR (ID_FORNECEDOR);

CREATE TABLE TB_PRATO (
	ID SERIAL PRIMARY KEY,
	DESCRICAO VARCHAR(100) NOT NULL,
	RECEITA VARCHAR(200),
	OBSERVACAO VARCHAR(200),
	DATA_CRIACAO TIMESTAMP NOT NULL,
	DATA_ATUALIZACAO TIMESTAMP NOT NULL
);

CREATE TABLE TB_PRATO_TAG (
	ID_PRATO_TAG SERIAL PRIMARY KEY,
	ID_PRATO INTEGER NOT NULL,
	ID_TAG INTEGER NOT NULL
);
ALTER TABLE TB_PRATO_TAG ADD CONSTRAINT FK_PRATO_TAG_IDPRATO FOREIGN KEY (ID_PRATO) REFERENCES TB_PRATO (ID);
ALTER TABLE TB_PRATO_TAG ADD CONSTRAINT FK_PRATO_TAG_IDTAG FOREIGN KEY (ID_TAG) REFERENCES TB_TAG (ID_TAG);

CREATE TABLE TB_PRATO_ITEM (
	ID_PRATO_ITEM SERIAL PRIMARY KEY,
	ID_PRATO INTEGER NOT NULL,
	ID_ITEM INTEGER NOT NULL
);
ALTER TABLE TB_PRATO_ITEM ADD CONSTRAINT FK_PRATO_ITEM_IDPRATO FOREIGN KEY (ID_PRATO) REFERENCES TB_PRATO (ID);
ALTER TABLE TB_PRATO_ITEM ADD CONSTRAINT FK_PRATO_ITEM_IDITEM FOREIGN KEY (ID_ITEM) REFERENCES TB_ITEM (ID_ITEM);

CREATE TABLE TB_ITEMCARDAPIO (
	ID_ITEMCARDAPIO SERIAL PRIMARY KEY,
	ID_ITEM INTEGER,
	ID_PRATO INTEGER,
	VALORVENDA REAL NOT NULL,
	ATIVO BOOLEAN NOT NULL,
	DATAHORA TIMESTAMP NOT NULL
);
ALTER TABLE TB_ITEMCARDAPIO ADD CONSTRAINT FK_ITEMCARDAPIO_IDITEM FOREIGN KEY (ID_ITEM) REFERENCES TB_ITEM (ID_ITEM);
ALTER TABLE TB_ITEMCARDAPIO ADD CONSTRAINT FK_ITEMCARDAPIO_IDPRATO FOREIGN KEY (ID_PRATO) REFERENCES TB_PRATO (ID);

CREATE TABLE TB_MESA (
	ID_MESA SERIAL PRIMARY KEY,
	OBSERVACAO VARCHAR(100)
);

CREATE TABLE TB_COMANDA (
	ID_COMANDA SERIAL PRIMARY KEY,
	ID_MESA INTEGER NOT NULL,
	DATAHORA TIMESTAMP NOT NULL,
	OBSERVACAO VARCHAR(100)
);
ALTER TABLE TB_COMANDA ADD CONSTRAINT FK_COMANDA_MESA FOREIGN KEY (ID_MESA) REFERENCES TB_MESA (ID_MESA);

CREATE TABLE TB_PEDIDO (
	ID_PEDIDO SERIAL PRIMARY KEY,
	ID_ITEMCARDAPIO INTEGER NOT NULL,
	ID_COMANDA INTEGER,
	DATAHORA TIMESTAMP NOT NULL
);
ALTER TABLE TB_PEDIDO ADD CONSTRAINT FK_PEDIDO_ITEMCARDAPIO FOREIGN KEY (ID_ITEMCARDAPIO) REFERENCES TB_ITEMCARDAPIO (ID_ITEMCARDAPIO);
ALTER TABLE TB_COMANDA ADD CONSTRAINT FK_PEDIDO_COMANDA FOREIGN KEY (ID_COMANDA) REFERENCES TB_COMANDA (ID_COMANDA);
