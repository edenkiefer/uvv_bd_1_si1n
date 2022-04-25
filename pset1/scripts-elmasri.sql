/* Criando o schema onde väo ficar as tabelas do projeto Elmasri 
 * e adicionando a permissão apenas para o usuário criado(como orientado no projeto) */
create schema elmasri authorization "eden.kiefer";

-- Criando a tabela de funcionarios
create table elmasri.funcionario (
	cpf char(11) primary key,
	primeiro_nome varchar(15) not null,
	nome_meio char(1),
	ultimo_nome varchar(15) not null,
	data_nascimento date,
	endereco varchar(10),
	sexo char(1),
	salario decimal(10, 2),
	cpf_supervisor char(11) not null references elmasri.funcionario(cpf),
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
	nome_departamento varchar(15) not null,
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
	nome_projeto varchar(15) not null,
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
	horas decimal(3,1) not null,
	primary key(cpf_funcionario, numero_projeto)
);
-- Comentando a tabela e as colunas logo após a criação
comment on table elmasri.trabalha_em is 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
comment on column elmasri.trabalha_em.cpf_funcionario is 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
comment on column elmasri.trabalha_em.numero_projeto is 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
comment on column elmasri.trabalha_em.horas is 'Horas trabalhadas pelo funcionário neste projeto.';