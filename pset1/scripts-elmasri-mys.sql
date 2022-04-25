-- Criando a tabela de funcionario com as colunas e a tabela já comentadas.
create table funcionario (
	cpf char(11) not null COMMENT "CPF do funcionário. Será a PK da tabela.",
	primeiro_nome varchar(15) not null COMMENT "Primeiro nome do funcionário.",
	nome_meio char(1) COMMENT "Inicial do nome do meio.",
	ultimo_nome varchar(15) not null COMMENT "Sobrenome do funcionário.",
	data_nascimento date,
	endereco varchar(10) COMMENT "Endereço do funcionário.",
	sexo char(1) COMMENT "Sexo do funcionário.",
	salario decimal(10, 2) COMMENT "Salário do funcionário.",
	cpf_supervisor char(11) not null COMMENT "CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).",
	numero_departamento integer not null COMMENT "Número do departamento do funcionário.",
	primary key (cpf),
	foreign key (cpf_supervisor) references funcionario(cpf)
) COMMENT "Tabela que armazena as informações dos funcionários.";

-- Criando a tabela de dependente com as colunas e a tabela já comentadas.
create table dependente (
	cpf_funcionario char(11) not null COMMENT "CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.",
	nome_dependente varchar(15) not null COMMENT "Nome do dependente. Faz parte da PK desta tabela.",
	sexo char(1) COMMENT "Sexo do dependente.",
	data_nascimento date COMMENT "Data de nascimento do dependente.",
	parentesco varchar(15) COMMENT "Descrição do parentesco do dependente com o funcionário.",
	primary key(cpf_funcionario, nome_dependente),
	foreign key (cpf_funcionario) references funcionario(cpf)
) COMMENT "Tabela que armazena as informações dos dependentes dos funcionários.";

-- Criando a tabela de departamento com as colunas e a tabela já comentadas.
create table departamento (
	numero_departamento integer not null COMMENT "Número do departamento. É a PK desta tabela.",
	nome_departamento varchar(15) not null COMMENT "Nome do departamento. Deve ser único.",
	cpf_gerente char(11) not null COMMENT "CPF do gerente do departamento. É uma FK para a tabela funcionários.",
	data_inicio_gerente date COMMENT "Data do início do gerente no departamento.",
	primary key (numero_departamento),
	foreign key (cpf_gerente) references funcionario(cpf)
) COMMENT "Tabela que armazena as informaçoẽs dos departamentos.";

-- Criando a tabela de localizacoes_departamento com as colunas e a tabela já comentadas.
create table localizacoes_departamento (
	numero_departamento integer not null COMMENT "Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.",
	local varchar(15) not null COMMENT "Localização do departamento. Faz parte da PK desta tabela.",
	primary key(numero_departamento, local),
	foreign key (numero_departamento) references departamento(numero_departamento)
) COMMENT "Tabela que armazena as possíveis localizações dos departamentos.";

-- Criando a tabela de projeto com as colunas e a tabela já comentadas. 
create table projeto (
	numero_projeto integer not null COMMENT "Número do projeto. É a PK desta tabela.",
	nome_projeto varchar(15) not null COMMENT "Nome do projeto. Deve ser único.",
	local_projeto varchar(15) COMMENT "Localização do projeto.",
	numero_departamento integer not null COMMENT "Número do departamento. É uma FK para a tabela departamento." ,
	primary key(numero_projeto),
	foreign key (numero_departamento) references departamento(numero_departamento)
) COMMENT "Tabela que armazena as informações sobre os projetos dos departamentos.";

-- Criando a tabela de projeto 
create table trabalha_em (
	cpf_funcionario char(11) not null COMMENT "CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.",
	numero_projeto integer not null COMMENT "Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.",
	horas decimal(3,1) not null COMMENT "Horas trabalhadas pelo funcionário neste projeto.",
	primary key(cpf_funcionario, numero_projeto),
	foreign key (cpf_funcionario) references funcionario(cpf),
	foreign key (numero_projeto) references projeto(numero_projeto)
) COMMENT "Tabela para armazenar quais funcionários trabalham em quais projetos.";