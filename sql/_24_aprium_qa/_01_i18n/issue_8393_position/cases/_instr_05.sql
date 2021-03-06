--+ holdcas on;
set names iso88591;
drop table if exists t;
create table t (i int, s char(20) collate iso88591_en_ci);

insert into t values (1,'Ca_ca__Ec_EaCa_ca__Ec_Ea');
insert into t values (2,'__cE_C _a_AC_Ch___cE_C _a_AC_Ch_');
insert into t values (3,'hcE_ca_A_C_EhcE_ca_A_C_E');
insert into t values (4,'Ec_aC_E_CEc_aC_E_C');
insert into t values (5,'Ec_A_aC_E_CEc_A_aC_E_C');

select i,s, instr (s,'Ca',1) from t order by 1;
select i,s, instr (s,'Ca',-1) from t order by 1;

select i,s, instr (s,'ca',1) from t order by 1;
select i,s, instr (s,'ca',-1) from t order by 1;

select i,s, instr (s,'C',1) from t order by 1;
select i,s, instr (s,'C',-1) from t order by 1;

select i,s, instr (s,'C ',1) from t order by 1;
select i,s, instr (s,'C ',-1) from t order by 1;

select i,s, instr (s,'A',1) from t order by 1;
select i,s, instr (s,'A',-1) from t order by 1;

select i,s, instr (s,'AC',1) from t order by 1;
select i,s, instr (s,'AC',-1) from t order by 1;

select i,s, instr (s,'Ec',1) from t order by 1;
select i,s, instr (s,'Ec',-1) from t order by 1;

select i,s, instr (s,'ce',1) from t order by 1;
select i,s, instr (s,'ce',-1) from t order by 1;

drop table t;
set names iso88591;
commit;
--+ holdcas off;
