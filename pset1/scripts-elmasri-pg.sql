/* Todos as tabelas a seguir foram para o schema elmasri
 * criado no meu banco como o pset indica, porém no pset
 * pede apenas a criação das tabelas e das inserções, na
 * dúvida deixei comentado aqui o script para criação do
 * schema e mais um script já criando e atribuindo ao meu
 * usuário criado a permissão.
 * Criando o schema onde väo ficar as tabelas do projeto Elmasri 
 * e adicionando a permissão apenas para o usuário criado(como orientado no projeto) 
 * create schema elmasri authorization;
 * ou
 * create schema elmasri authorization "eden.kiefer";
 */

-- Criando a tabela de funcionarios
create table elmasri.funcionario (
	cpf char(11) primary key,
	primeiro_nome varchar(15) not null,
	nome_meio char(1),
	ultimo_nome varchar(15) not null,
	data_nascimento date,
	endereco varchar(30),
	sexo char(1),
	salario decimal(10, 2),
	cpf_supervisor char(11) references elmasri.funcionario(cpf),
	numero_departamento integer not null
);
-- Comentando a tabela e as colunas logo após a criação
comment on table elmasri.funcionario is 'Tabela que armazena as informações dos funcionários.';
comment on column elmasri.funcionario.cpf is 'CPF do funcionário. Será a PK da tabela.';
comment on column elmasri.funcionario.primeiro_nome is 'Primeiro nome do funcionário.';
comment on column elmasri.funcionario.nome_meio is 'Inicial do nome do meio.';
comment on column elmasri.funcionario.ultimo_nome is 'Sobrenome do funcionário.';
comment on column elmasri.funcionario.endereco is 'Endereço do funcionário.';
comment on column elmasri.funcionario.sexo is 'Sexo do funcionário.';
comment on column elmasri.funcionario.salario is 'Salário do funcionário.';
comment on column elmasri.funcionario.cpf_supervisor is 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';
comment on column elmasri.funcionario.numero_departamento is 'Número do departamento do funcionário.';

-- Criando a tabela de dependentes
create table elmasri.dependente  (
	cpf_funcionario char(11) not null references elmasri.funcionario(cpf),
	nome_dependente varchar(15) not null,
	sexo char(1),
	data_nascimento date,
	parentesco varchar(15),
	primary key(cpf_funcionario, nome_dependente)
);
-- Comentando a tabela e as colunas logo após a criação
comment on table elmasri.dependente is 'Tabela que armazena as informações dos dependentes dos funcionários.';
comment on column elmasri.dependente.cpf_funcionario is 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
comment on column elmasri.dependente.nome_dependente is 'Nome do dependente. Faz parte da PK desta tabela.';
comment on column elmasri.dependente.sexo is 'Sexo do dependente.';
comment on column elmasri.dependente.data_nascimento is 'Data de nascimento do dependente.'; 
comment on column elmasri.dependente.parentesco is 'Descrição do parentesco do dependente com o funcionário.'; 

-- Criando a tabela de departamento 
create table elmasri.departamento (
	numero_departamento integer primary key,
	nome_departamento varchar(15) unique not null,
	cpf_gerente char(11) not null references elmasri.funcionario(cpf),
	data_inicio_gerente date
);
-- Comentando a tabela e as colunas logo após a criação
comment on table elmasri.departamento is 'Tabela que armazena as informaçoẽs dos departamentos.';
comment on column elmasri.departamento.numero_departamento is 'Número do departamento. É a PK desta tabela.';
comment on column elmasri.departamento.nome_departamento is 'Nome do departamento. Deve ser único.';
comment on column elmasri.departamento.cpf_gerente is 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';
comment on column elmasri.departamento.data_inicio_gerente is 'Data do início do gerente no departamento.';

-- Criando a tabela de localizacoes_departamento 
create table elmasri.localizacoes_departamento (
	numero_departamento integer not null references elmasri.departamento(numero_departamento),
	local varchar(15) not null,
	primary key(numero_departamento, local)
);
-- Comentando a tabela e as colunas logo após a criação
comment on table elmasri.localizacoes_departamento is 'Tabela que armazena as possíveis localizações dos departamentos.';
comment on column elmasri.localizacoes_departamento.numero_departamento is 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';
comment on column elmasri.localizacoes_departamento.local is 'Localização do departamento. Faz parte da PK desta tabela.';

-- Criando a tabela de projeto 
create table elmasri.projeto (
	numero_projeto integer primary key,
	nome_projeto varchar(15) unique not null,
	local_projeto varchar(15),
	numero_departamento integer not null references elmasri.departamento(numero_departamento)
);
-- Comentando a tabela e as colunas logo após a criação
comment on table elmasri.projeto is 'Tabela que armazena as informações sobre os projetos dos departamentos.';
comment on column elmasri.projeto.numero_projeto is 'Número do projeto. É a PK desta tabela.';
comment on column elmasri.projeto.nome_projeto is 'Nome do projeto. Deve ser único.';
comment on column elmasri.projeto.local_projeto is 'Localização do projeto.';
comment on column elmasri.projeto.numero_departamento is 'Número do departamento. É uma FK para a tabela departamento.';

-- Criando a tabela de projeto 
create table elmasri.trabalha_em (
	cpf_funcionario char(11) not null references elmasri.funcionario(cpf),
	numero_projeto integer not null references elmasri.projeto(numero_projeto),
	horas decimal(3,1),
	primary key(cpf_funcionario, numero_projeto)
);
-- Comentando a tabela e as colunas logo após a criação
comment on table elmasri.trabalha_em is 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
comment on column elmasri.trabalha_em.cpf_funcionario is 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
comment on column elmasri.trabalha_em.numero_projeto is 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
comment on column elmasri.trabalha_em.horas is 'Horas trabalhadas pelo funcionário neste projeto.';

/* Aqui começa a inserção dos dados */

-- Inserindo os dados dos funcionarios na tabela de funcionarios
INSERT INTO elmasri.funcionario
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
INSERT INTO elmasri.departamento 
values 
	(5,'Pesquisa',33344555587,'1988-05-22'),
    (4, 'Administração',98765432168,'1995-01-01'),
    (1, 'Matriz', 88866555576,'1981-06-19');

-- Inserindo os dados de onde fica a localizão dos departamentos na tabela localizacoes_departamento
INSERT INTO elmasri.localizacoes_departamento 
values  
	(1,'São Paulo'),
    (4,'Mauá'),
    (5,'Santo André'),
    (5,'Itu'),
    (5,'São Paulo');

-- Inserindo os dados dos projetos na tabela de projeto
INSERT INTO elmasri.projeto 
values  
	(1,'ProdutoX','Santo André',5),
	(2,'ProdutoY','Ittu',5),
	(3,'ProdutoZ','São Paulo',5),
	(10,'Informatização','Mauá',4),
	(20,'Reorganização','São Paulo',1),
	(30,'Novosbenefícios','Mauá',4);
     
-- Inserindo os dados dos dependestes dos funcionarios na tabela dependente
INSERT INTO elmasri.dependente 
values  
	(33344555587,'Alicia','F','1986-04-05','filha'),
	(33344555587,'Tiago','M','1983-10-25','filho'),
	(33344555587,'Janaína','F','1958-05-03','esposa'),
	(98765432168,'Antonio','M','1942-02-28','marido'),
	(12345678966,'Michael','M','1988-01-04','filho'),
	(12345678966,'Alicia','F','1988-12-30','filha'),
	(12345678966,'Elizabeth','F','1967-05-05','esposa');

-- Inserindo os dados de onde projeto o funcionario atua e quantas horas na tabela trabalha_em
INSERT INTO elmasri.trabalha_em 
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