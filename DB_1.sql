--Однотабличные запросы

--1
select st.name, st.surname
from students st
where st.score>=4 and st.score<=4.5;

select st.name, st.surname
from students st
where st.score between 4 and 4.5;

select st.name, st.surname
from students st
where not st.score<4 and not st.score>4.5;

--2
select st.name, st.surname
from students st
where st.n_group::varchar like '2%';

--3
select st.name, st.surname, st.n_group
from students st
order by st.n_group desc, st.name;

--4
select st.name, st.surname, st.score
from students st
where st.score > 4
order by st.score desc;

--5
select hb.name, hb.risk
from hobbies hb
where hb.name = 'Футбол' or hb.name = 'Хоккей';

--6
select sh.student_id, sh.hobby_id, sh.date_start, sh.date_finish
from students_hobbies sh
where (sh.date_start between '2016-05-15' and '2019-01-01') and sh.date_finish is null;

--7
select st.name, st.surname, st.score
from students st
where st.score > 4.5
order by st.score desc;

--8
select st.name, st.surname, st.score
from students st
where st.score > 4.5
order by st.score desc
limit 5;

SELECT name, surname, score
FROM students
WHERE score =
(SELECT max(score)
FROM students)
limit 5;

--9
select name, case
when risk>=8 then 'очень высокий'
when risk<8 and risk>=6 then 'высокий'
when risk<6 and risk>=4 then 'средний'
when risk<4 and risk>=2 then 'низкий'
when risk<2 then 'очень низкий'
end
from hobbies;

--10
select name
from hobbies
order by risk desc
limit 3;

--Групповые функции

--1
select n_group, count(n_group)
from students
group by n_group;

--2
select n_group, MAX(score), AVG(score)
from students
group by n_group;

--3
select st.surname, count(st.surname)
from students st
group by st.surname;

--4
select extract(year from st.birth_date) as t, count(*)
from students st
group by t;

--5
select substr(st.n_group::varchar,1,1), avg(score)
from students st
group by substr(st.n_group::varchar,1,1);

--6
select substr(st.n_group::varchar,1,1), avg(score)
from students st
group by substr(st.n_group::varchar,1,1)
order by avg(score) desc
limit 1;

--8
select st.n_group, count(n_group), max(score), avg(score), min(score)
from students st
group by st.n_group;

--9
select st.*
from students st inner join
(
	select st.n_group, max(st.score) as m
 	from students st
 	group by st.n_group
) t
on st.n_group=t.n_group and st.score=t.m;

Explain Analyze 
with t as 
(
	select st.n_group, max(st.score) as m
 	from students st
 	group by st.n_group
)
select st.*
from students st inner join t on st.n_group=t.n_group and st.score=t.m;


--10
--???????
select st.*
from students st inner join
(
	select st.n_group, max(st.score) as m
 	from students st
 	group by st.n_group

) t
on st.n_group=t.n_group and st.score=t.m;

--Многотабличные запросы

--1
select st.name, st.surname, h.name, h.risk, st.score
from students st inner join students_hobbies sh on st.id = sh.student_id inner join hobbies h on sh.hobby_id = h.id;

--2
select st.name, st.surname, h.name
from students st inner join students_hobbies sh on st.id = sh.student_id inner join hobbies h on sh.hobby_id = h.id
where sh.date_finish-sh.date_start=(select max(date_finish-date_start) from students_hobbies);

--3
select st.name, st.surname, avg(st.score), st.score
from students st inner join students_hobbies sh on st.id = sh.student_id inner join hobbies h on sh.hobby_id = h.id
where st.score>(select avg(score) from students)
group by st.name, st.surname, st.score
having sum(h.risk)>0.9;

--4
select st.name, st.surname, h.name, sh.date_finish-sh.date_start, sh.date_start, sh.date_finish
from students st inner join students_hobbies sh on st.id = sh.student_id inner join hobbies h on sh.hobby_id = h.id
where sh.date_finish is not null;

--5
create view active_hobbies10 as
select sh.student_id
from students_hobbies sh
where sh.date_finish is null
group by sh.student_id
having count(*)>1;

select st.*
from students st
inner join active_hobbies10 ah on st.id =ah.student_id
where extract(year from age(now(),st.birth_date))>=20;

select st.*
from students st
inner join (select sh.student_id
from students_hobbies sh
where sh.date_finish is null
group by sh.student_id
having count(*)>1) ah on st.id =ah.student_id
where extract(year from age(now(),st.birth_date))>=20;

--6
select st.n_group, avg(st.score)
from students st left join students_hobbies sh on st.id=sh.student_id
group by st.n_group;

--7
select h.name, h.risk, st.id, st.n_group
from students st inner join students_hobbies sh on st.id = sh.student_id inner join hobbies h on sh.hobby_id = h.id
where sh.date_start=(select max(h.date_start) from students_hobbies h) and sh.date_finish is null;

--8
select h.name
from students st inner join students_hobbies sh on st.id = sh.student_id inner join hobbies h on sh.hobby_id = h.id
where st.score=(select max(st.score) from students st);

--9
select h.name
from students st inner join students_hobbies sh on st.id = sh.student_id inner join hobbies h on sh.hobby_id = h.id
where sh.date_start is null and st.score<=3;

--10
--????
select st.n_group
from students st
where (count(select st.id from students st inner join students_hobbies sh on st.id = sh.student_id where sh.date_finish is null group by st.n_group)::real) / (count(select * from students group by n_group)::real)>0,5

--16
select t2.hobby_id
from 
(
select sh.hobby_id, count(sh.hobby_id) as t
from students_hobbies sh
group by sh.hobby_id
order by t desc
limit 1
) t2;

--семинар
select substr(st.n_group::varchar,1,1), avg(score)
from students st
group by substr(st.n_group::varchar,1,1);

select age(sh.date_finish, sh.date_start), extract (month from age(sh.date_finish, sh.date_start))+extract(year from age(sh.date_finish, sh.date_start))*12
from students_hobbies sh;

select st.name, st.surname, avg(st.score), st.score
from students st inner join students_hobbies sh on st.id = sh.student_id inner join hobbies h on sh.hobby_id = h.id
group by st.name, st.surname, st.score
having sum(h.risk)>0.9 and st.score>(select avg(score) from students);
