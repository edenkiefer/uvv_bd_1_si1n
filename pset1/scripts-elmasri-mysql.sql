/* No meu PC estava acontecendo um bug ou algo assim, quando 
 * eu tentava rodar todos os comandos de uma vez não ia, 
 * só estava indo de um a um na sequencia que está no script, 
 * caso isso aconteça peço a consideração de rodar os comandos 
 * um a um também.
*/

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
	cpf_supervisor char(11) COMMENT "CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).",
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
	nome_departamento varchar(15) unique not null COMMENT "Nome do departamento. Deve ser único.",
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
	nome_projeto varchar(15) unique not null COMMENT "Nome do projeto. Deve ser único.",
	local_projeto varchar(15) COMMENT "Localização do projeto.",
	numero_departamento integer not null COMMENT "Número do departamento. É uma FK para a tabela departamento." ,
	primary key(numero_projeto),
	foreign key (numero_departamento) references departamento(numero_departamento)
) COMMENT "Tabela que armazena as informações sobre os projetos dos departamentos.";

-- Criando a tabela de trabalha_em com as colunas e a tabela já comentadas
create table trabalha_em (
	cpf_funcionario char(11) not null COMMENT "CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.",
	numero_projeto integer not null COMMENT "Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.",
	horas decimal(3,1) COMMENT "Horas trabalhadas pelo funcionário neste projeto.",
	primary key(cpf_funcionario, numero_projeto),
	foreign key (cpf_funcionario) references funcionario(cpf),
	foreign key (numero_projeto) references projeto(numero_projeto)
) COMMENT "Tabela para armazenar quais funcionários trabalham em quais projetos.";

/* Aqui começa a inserção dos dados */

-- Inserindo os dados dos funcionarios na tabela de funcionarios
INSERT INTO funcionario
values 
	(88866555576, 'Jorge','E','Brito','1937-11-10','R. do Horto,35,São Paulo,SP','M',55000, null ,1),
	(98765432168, 'Jennifer','S','Souza','1941-06-20','Av. Arthur de Lima,54,S.A,SP','F',43000,88866555576,4),
	(33344555587, 'Fernando','T','Wong','1955-12-08','R. da Lapa,34,São Paulo,SP','M',40000,88866555576,5),
	(99988777767, 'Alice','J','Zelaya','1968-01-19','R. Souza Lima,35,Curitiba,PR','F',25000,98765432168,4),
	(98798798733, 'André','V','Pereira','1969-03-29','R. Timbira,35,São Paulo, SP','M',25000,98765432168,4),
	(12345678966,'João','B','Silva','1965-01-09','R. das Flores,751,São Paulo,Sp','M',30000,33344555587,5),
	(66688444476, 'Ronaldo','K','Lima','1962-09-15','R. Rebouças,65,Piracicaba,SP','M',38000,33344555587,5),
	(45345345376, 'Joice','A','Leite','1972-07-31','Av. Lucas Obes,74 São Paulo,SP','F',25000,33344555587,5);

-- Inserindo os dados dos departamentos na tabela departamento
INSERT INTO departamento 
values 
	(5,'Pesquisa',33344555587,'1988-05-22'),
    (4, 'Administração',98765432168,'1995-01-01'),
    (1, 'Matriz', 88866555576,'1981-06-19');

-- Inserindo os dados de onde fica a localizão dos departamentos na tabela localizacoes_departamento
INSERT INTO localizacoes_departamento 
values  
	(1,'São Paulo'),
    (4,'Mauá'),
    (5,'Santo André'),
    (5,'Itu'),
    (5,'São Paulo');

-- Inserindo os dados dos projetos na tabela de projeto
INSERT INTO projeto 
values  
	(1,'ProdutoX','Santo André',5),
	(2,'ProdutoY','Ittu',5),
	(3,'ProdutoZ','São Paulo',5),
	(10,'Informatização','Mauá',4),
	(20,'Reorganização','São Paulo',1),
	(30,'Novosbenefícios','Mauá',4);
     
-- Inserindo os dados dos dependestes dos funcionarios na tabela dependente
INSERT INTO dependente 
values  
	(33344555587,'Alicia','F','1986-04-05','filha'),
	(33344555587,'Tiago','M','1983-10-25','filho'),
	(33344555587,'Janaína','F','1958-05-03','esposa'),
	(98765432168,'Antonio','M','1942-02-28','marido'),
	(12345678966,'Michael','M','1988-01-04','filho'),
	(12345678966,'Alicia','F','1988-12-30','filha'),
	(12345678966,'Elizabeth','F','1967-05-05','esposa');

-- Inserindo os dados de onde projeto o funcionario atua e quantas horas na tabela trabalha_em
INSERT INTO trabalha_em 
values
	(12345678966,1,32.5),
	(12345678966,2,7.5),
	(66688444476,3,40.0),
	(45345345376,1,20.0),
	(45345345376,2,20.0),
	(33344555587,2,10.0),
	(33344555587,3,10.0),
	(33344555587,10,10.0),
	(33344555587,20,10.0),
	(99988777767,30,30.0),
	(99988777767,10,10.0),
	(98798798733,10,35.0),
	(98798798733,30,5.0),
	(98765432168,30,20.0),
	(98765432168,20,15.0),
	(88866555576,20,null);