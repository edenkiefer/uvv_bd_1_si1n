-- Relatório da média salarial dos funcionários de cada departamento
select 
d.nome_departamento,
round(avg(f.salario)) as media_salarial
from elmasri.funcionario f 
join elmasri.departamento d on d.numero_departamento = f.numero_departamento 
group by d.numero_departamento;
-- Relatório da média salarial dos homens e das mulheres
select 
f.sexo,
round(avg(f.salario)) as media_salarial
from elmasri.funcionario f 
group by f.sexo;
-- Relatório que lista o nome dos departamentos e, para cada departamento
select 
d.nome_departamento,
(f.primeiro_nome || ' ' || f.nome_meio || '. ' || f.ultimo_nome) as nome_completo,
f.data_nascimento,
date_part('year', age(CURRENT_DATE, f.data_nascimento)) as idade,
f.salario 
from elmasri.departamento d 
inner join elmasri.funcionario f on f.numero_departamento = d.numero_departamento
order by nome_departamento;
-- Relatório que mostra o nome e a idade dos funcionarios, além do reajuste no salário
select 
(f.primeiro_nome || ' ' || f.nome_meio || '. ' || f.ultimo_nome) as nome_completo,
date_part('year', age(CURRENT_DATE, f.data_nascimento)) as idade,
salario,
case when salario < 35000 then salario + ((salario/100) * 20)
	 else salario + ((salario/100) * 15)
end as salario
from elmasri.funcionario f;
-- Relatório que lista para cada departamento, o nome do gerente e o nome dos funcionários
select 
f2.primeiro_nome as nome_gerente,
f.primeiro_nome as nome_funcionario
from elmasri.departamento d
join elmasri.funcionario f on f.numero_departamento = d.numero_departamento
join elmasri.funcionario f2 on f2.cpf = d.cpf_gerente 
order by d.nome_departamento asc, f.salario desc;
-- Relatório dos dependentes
select 
(f.primeiro_nome || ' ' || f.nome_meio || '. ' || f.ultimo_nome) as nome_completo,
dpt.nome_departamento,
d.nome_dependente,
date_part('year', age(CURRENT_DATE, d.data_nascimento)) as idade_dependente,
case when d.sexo = 'M' then 'Masculino'
	else 'Feminino'
end as sexo_dependente
from elmasri.funcionario f 
join elmasri.dependente d on d.cpf_funcionario = f.cpf
join elmasri.departamento dpt on dpt.numero_departamento = f.numero_departamento;
-- Relatório dos funcionarios sem dependentes
select 
(f.primeiro_nome || ' ' || f.nome_meio || '. ' || f.ultimo_nome) as nome_completo,
dpt.nome_departamento,
f.salario 
from elmasri.funcionario f 
left join elmasri.dependente d on d.cpf_funcionario = f.cpf 
join elmasri.departamento dpt on dpt.numero_departamento = f.numero_departamento 
where d.cpf_funcionario is null;
-- Relatório que mostra, para cada departamento, os projetos desse departamento e o nome completo dos funcionários que estão alocados em cada projeto.
select 
d.nome_departamento,
p.nome_projeto,
(f.primeiro_nome || ' ' || f.nome_meio || '. ' || f.ultimo_nome) as nome_funcionario,
te.horas 
from elmasri.departamento d 
right join elmasri.projeto p on p.numero_departamento = d.numero_departamento
right join elmasri.trabalha_em te on te.numero_projeto = p.numero_projeto 
right join elmasri.funcionario f on f.cpf = te.cpf_funcionario;
-- Relatório que mostra a soma total das horas de cada projeto em cada departamento
select 
d.nome_departamento,
p.nome_projeto,
SUM(te.horas) as horas
from elmasri.departamento d 
inner join elmasri.projeto p on p.numero_departamento = d.numero_departamento
inner join elmasri.trabalha_em te on te.numero_projeto = p.numero_projeto
group by d.numero_departamento, p.numero_projeto;
-- Relatório que mostra a média salarial dos funcionários de cada departamento.
select 
d.nome_departamento,
round(avg(f.salario)) as media_salarial
from elmasri.funcionario f 
join elmasri.departamento d on d.numero_departamento = f.numero_departamento 
group by d.numero_departamento;
-- Relatório que mostra o valor por hora trabalhada(50 por hora)
select 
(f.primeiro_nome || ' ' || f.nome_meio || '. ' || f.ultimo_nome) as nome_funcionario,
sum(te.horas) * 50 as horas
from elmasri.funcionario f 
join elmasri.trabalha_em te on te.cpf_funcionario = f.cpf
left join elmasri.projeto p on p.numero_projeto = te.numero_projeto
group by f.cpf, te.cpf_funcionario;
-- Relatório que mostra os funcionarios que não tem horas registradas
select 
(f.primeiro_nome || ' ' || f.nome_meio || '. ' || f.ultimo_nome) as nome_funcionario,
p.nome_projeto,
sum(te.horas) horas
from elmasri.funcionario f 
join elmasri.trabalha_em te on te.cpf_funcionario = f.cpf
left join elmasri.projeto p on p.numero_projeto = te.numero_projeto
where te.horas is null
group by f.cpf, te.cpf_funcionario, p.numero_projeto;