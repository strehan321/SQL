/**************************************************************
  BASIC SELECT STATEMENTS
**************************************************************/

/**************************************************************
  IDs, names, and GPAs of students with GPA > 3.6
**************************************************************/

select sID, sName, GPA
from Student
where GPA > 3.6;

/*** Same query without GPA ***/

select sID, sName
from Student
where GPA > 3.6;

/**************************************************************
  Student names and majors for which they've applied
**************************************************************/

select sName, major
from Student, Apply
where Student.sID = Apply.sID;

/*** Same query with Distinct ***/

select distinct sName, major
from Student, Apply
where Student.sID = Apply.sID;

/**************************************************************
  Names and GPAs of students with sizeHS < 1000 applying to
  CS at Stanford, and the application decision
**************************************************************/

select sname, GPA, decision
from Student, Apply
where Student.sID = Apply.sID
  and sizeHS < 1000 and major = 'CS' and cname = 'Stanford';

/**************************************************************
  All large campuses with CS applicants
**************************************************************/

select distinct College.cName
from College, Apply
where College.cName = Apply.cName
  and enrollment > 20000 and major = 'CS';

/**************************************************************
  Application information
**************************************************************/

select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName
order by GPA desc, enrollment;

/**************************************************************
  Applicants to bio majors
**************************************************************/

select sID, major
from Apply
where major like '%bio%';

/**************************************************************
  Select * cross-product
**************************************************************/

select *
from Student, College;

/**************************************************************
  Add scaled GPA based on sizeHS
**************************************************************/

select sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0) as scaledGPA
from Student;
