
create database dbbanco;

use dbbanco;

create table tbcompra( -- Recebo do fornecedor (Compra dp forn.) -1
	NotaFiscal int primary key,
    dataCompra date not null,
    valorTotal decimal not null,
    QtdTotal int not null,
    Codigo int(10),
    ProdId int,
	ItemId varchar(30),
	FOREIGN KEY (ItemId) references tbItemCompra(ItemId)
);

create table tbItemCompra( -- - 2
	NF int,
	QtdItem int,
	ValorUni decimal(2),
	FornecId int,
	ItemId varchar(30) primary key,
    FOREIGN KEY (NF) references tbNotaFiscal(NF),
    FOREIGN KEY (FornecId) references tbfornecedor(FornecId)
);


alter table tbItemCompra ADD CONSTRAINT FornecId FOREIGN KEY (FornecId) references tbFornecedor;

create table tbItemVenda( -- - 2
	NumVenda int primary key,
    DataVenda date,
    TotalVenda decimal not null,
    CliId int(11) not null,
    NF int null,
	FOREIGN KEY (CliId) references tbcliente(CliId),
    FOREIGN KEY (NF) references tbnotafiscal(NF)
);

alter table tbItemVenda modify column DataVenda date;
alter table tbItemVenda modify column DataVenda date default(current_timestamp());

create table tbvenda(
	NumeroVenda int primary key,
    CodigoBarras int(14),
    ValorItem decimal not null,
    Qtd int not null,
    Foreign key (CodigoBarras) references tbProduto(CodigoBarras)
);

drop table tbvenda;

create table tbnotafiscal( -- -9
	NF int primary key,
    TotalNota decimal not null,
    dataEmissao date not null
);

drop table tbnotafiscal;

create table tbproduto( -- O produto em si -4
	CodigoBarras int(14) primary key,
	Nome varchar(200) not null,
	Valor decimal not null,
    Qtd int null
);

select * from tbproduto;

create table tbcliente( -- O cliente -5
	Nome varchar(200),
	CliId int primary key,
    numEndereco int(6) not null,
	Cpf varchar(50),
	Cnpj varchar(50),
    CompEnd varchar(20),
	CEP varchar(8),
	foreign key (Cpf) references tbcliente_pf(Cpf),
	foreign key (Cnpj) references tbcliente_pj(Cnpj),
	foreign key (CEP) references tbendereco(CEP)
);

drop table tbcliente;

create table tbendereco(
	CEP varchar(8) primary key,
	BairroId int,
	CidadeId int,
	UFId int,
    Logradouro varchar(200) not null,
	foreign key (BairroId) references tbBairro(BairroId),
	foreign key (CidadeId) references tbCidade(CidadeId),
	foreign key (UFId) references tbUF(UFId)
);
    
drop table tbcliente;
drop table tbendereco;
    
create table tbBairro(
	BairroId int auto_increment primary key,
	NomeBairro varchar(200) not null
);

create table tbCidade( -- -6
	CidadeId int auto_increment primary key,
	NomeCid varchar(200) not null
);

create table tbUF(
	UFId int auto_increment primary key,
	NomeUF varchar(2) not null
);

create table tbcliente_pf( -- -7
	Cpf varchar(30) primary key,
	rg varchar(30) not null,
	rgDig char not null,
	datanasc date not null
);

create table tbcliente_pj( -- -8
	Cnpj varchar(30) primary key,
	IE int unique
    -- Inscrição Estadual
);

-- Nota Fiscal & Venda
create table tbfornecedor( -- -10
	Nome varchar(200) not null,
	CNPJ varchar(14) unique,
	Endereco varchar(50) not null,
    telefone varchar(11) null,
	FornecId int primary key
);

ALTER TABLE tbcompra ADD CONSTRAINT fk_tbfornecdor FOREIGN KEY (NotaFiscal) REFERENCES tbfornecedor (FornecId ) ;
ALTER TABLE tbvenda ADD CONSTRAINT fk_tbcliente FOREIGN KEY (Numerovenda) REFERENCES tbcliente (CliId ) ;
ALTER TABLE  tbProduto ADD CONSTRAINT fk_tbItemVenda FOREIGN KEY (CodigoBarras) REFERENCES tbitemvenda (NF);
ALTER TABLE  tbProduto ADD CONSTRAINT fk_tbItemCompra FOREIGN KEY (CodigoBarras) REFERENCES tbitemcompra (ItemId);
ALTER TABLE  tbProduto ADD CONSTRAINT fk_tbItemVenda FOREIGN KEY (CodigoBarras) REFERENCES tbitemvenda (NF);
ALTER TABLE  tbItemVenda ADD CONSTRAINT fk_tbVenda FOREIGN KEY (NumVenda) REFERENCES tbvenda (NumeroVenda);
ALTER TABLE  tbfornecedor ADD CONSTRAINT fk_tbitemcompra FOREIGN KEY (FornecId) REFERENCES tbitemcompra (itemid);




















