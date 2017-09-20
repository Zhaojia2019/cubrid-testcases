-- test with aggregate functions
create table tree(id int not null, parentid int, text varchar(64) not null);

create index i_tree_id on tree(id);
create index i_tree_parentid on tree(parentid);

insert into tree values(1,6,'AAAAA');
insert into tree values(2,6,'AAAAB');
insert into tree values(3,6,'AAAAC');
insert into tree values(4,6,'AAAAD');
insert into tree values(5,6,'AAAAE');
insert into tree values(6,31,'AAAA');
insert into tree values(7,12,'AAABA');
insert into tree values(8,12,'AAABB');
insert into tree values(9,12,'AAABC');
insert into tree values(10,12,'AAABD');
insert into tree values(11,12,'AAABE');
insert into tree values(12,31,'AAAB');
insert into tree values(13,18,'AAACA');
insert into tree values(14,18,'AAACB');
insert into tree values(15,18,'AAACC');
insert into tree values(16,18,'AAACD');
insert into tree values(17,18,'AAACE');
insert into tree values(18,31,'AAAC');
insert into tree values(19,24,'AAADA');
insert into tree values(20,24,'AAADB');
insert into tree values(21,24,'AAADC');
insert into tree values(22,24,'AAADD');
insert into tree values(23,24,'AAADE');
insert into tree values(24,31,'AAAD');
insert into tree values(25,30,'AAAEA');
insert into tree values(26,30,'AAAEB');
insert into tree values(27,30,'AAAEC');
insert into tree values(28,30,'AAAED');
insert into tree values(29,30,'AAAEE');
insert into tree values(30,31,'AAAE');

create index i_tree_id_parentid_text on tree(id, parentid, text);

select /*+ use_desc_idx */ count(*) from tree where id * id < parentid;
select /*+ use_desc_idx */ sum(id) from tree where id > 20;
select /*+ use_desc_idx */ sum(id) from tree where id >= 20 using index i_tree_id(+) keylimit 2;

drop table tree;