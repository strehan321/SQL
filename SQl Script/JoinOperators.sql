/**************************************************************
  JOIN OPERATORS
**************************************************************/

/**************************************************************
  INNER JOIN
  Student names and majors for which they've applied
**************************************************************/

select distinct sName, major
from Student, Apply
where Student.sID = Apply.sID;

/*** Using INNER JOIN ***/

select distinct sName, major
from Student inner join Apply
on Student.sID = Apply.sID;

/**************************************************************
  INNER JOIN WITH ADDITIONAL CONDITIONS
  Names and GPAs of students with sizeHS < 1000 applying to
  CS at Stanford
**************************************************************/

select sName, GPA
from Student, Apply
where Student.sID = Apply.sID
  and sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/*** Using JOIN ***/

select sName, GPA
from Student join Apply
on Student.sID = Apply.sID
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/*** Another JOIN condition ***/

select sName, GPA
from Student join Apply
on Student.sID = Apply.sID
and sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/**************************************************************
  THREE-WAY INNER JOIN
  Application info: ID, name, GPA, college name, enrollment
**************************************************************/

select Apply.sID, sName, GPA, Apply.cName, enrollment
from Apply, Student, College
where Apply.sID = Student.sID and Apply.cName = College.cName;

/*** Using three-way JOIN ***/

select Apply.sID, sName, GPA, Apply.cName, enrollment
from Apply join Student join College
on Apply.sID = Student.sID and Apply.cName = College.cName;

/*** Using binary JOIN ***/

select Apply.sID, sName, GPA, Apply.cName, enrollment
from (Apply join Student on Apply.sID = Student.sID) join College on Apply.cName = College.cName;

/**************************************************************
  NATURAL JOIN
  Student names and majors for which they've applied
**************************************************************/

select distinct sName, major
from Student inner join Apply
on Student.sID = Apply.sID;

/*** Using NATURAL JOIN ***/

select distinct sName, major
from Student natural join Apply;

/**************************************************************
  NATURAL JOIN WITH ADDITIONAL CONDITIONS
  Names and GPAs of students with sizeHS < 1000 applying to
  CS at Stanford
**************************************************************/

select sName, GPA
from Student join Apply
on Student.sID = Apply.sID
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/*** NATURAL JOIN ***/

select sName, GPA
from Student natural join Apply
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/*** USING clause ***/

select sName, GPA
from Student join Apply using(sID)
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/**************************************************************
  SELF-JOIN
  Pairs of students with same GPA
**************************************************************/

select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
where S1.GPA = S2.GPA and S1.sID < S2.sID;

/*** Without ON clause ***/

select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1 join Student S2 using(GPA)
where S1.sID < S2.sID;

/**************************************************************
  SELF NATURAL JOIN
**************************************************************/

select *
from Student S1 natural join Student S2;

/**************************************************************
  LEFT OUTER JOIN
  Student application info: name, ID, college name, major
**************************************************************/

select sName, sID, cName, major
from Student inner join Apply using(sID);

/*** Include students who haven't applied anywhere ***/

select sName, sID, cName, major
from Student left outer join Apply using(sID);

/***  LEFT JOIN ***/

select sName, sID, cName, major
from Student left join Apply using(sID);

/***  NATURAL OUTER JOIN ***/

select sName, sID, cName, major
from Student natural left outer join Apply;

/*** Without any JOIN operators ***/

select sName, Student.sID, cName, major
from Student, Apply
where Student.sID = Apply.sID
union
select sName, sID, NULL, NULL
from Student
where sID not in (select sID from Apply);

/*** Applications without matching students ***/

insert into Apply values (321, 'MIT', 'history', 'N');
insert into Apply values (321, 'MIT', 'psychology', 'Y');

select sName, sID, cName, major
from Apply natural left outer join Student;

/**************************************************************
  RIGHT OUTER JOIN
  Student application info: name, ID, college name, major
**************************************************************/

/*** Include applications without matching students ***/

select sName, sID, cName, major
from Student natural right outer join Apply;

/**************************************************************
  FULL OUTER JOIN
  Student application info
**************************************************************/

/*** Include students who haven't applied anywhere ***/
/*** and applications without matching students ***/

select sName, sID, cName, major
from Student full outer join Apply using(sID);

/**************************************************************
  THREE-WAY OUTER JOIN
  Not associative
**************************************************************/

create table T1 (A int, B int);
create table T2 (B int, C int);
create table T3 (A int, C int);
insert into T1 values (1,2);
insert into T2 values (2,3);
insert into T3 values (4,5);

select A,B,C
from (T1 natural full outer join T2) natural full outer join T3;

select A,B,C
from T1 natural full outer join (T2 natural full outer join T3);

drop table T1;
drop table T2;
drop table T3;
