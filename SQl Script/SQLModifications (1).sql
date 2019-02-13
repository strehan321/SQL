/**************************************************************
  INSERT, DELETE, AND UPDATE STATEMENTS
**************************************************************/

/**************************************************************
  Insert new college
**************************************************************/

insert into College values ('Carnegie Mellon', 'PA', 11500);

/**************************************************************
  Have all students who didn't apply anywhere apply to
  CS at Carnegie Mellon
**************************************************************/

insert into Apply
  select sID, 'Carnegie Mellon', 'CS', null
  from Student
  where sID not in (select sID from Apply);

/*** Admit to Carnegie Mellon EE all students who were turned down
     in EE elsewhere ***/

insert into Apply
  select sID, 'Carnegie Mellon', 'EE', 'Y'
  from Student
  where sID in (select sID from Apply
                where major = 'EE' and decision = 'N');

/**************************************************************
  Delete all students who applied to more than two different
  majors
**************************************************************/

delete from Student
where sID in
  (select sID
   from Apply
   group by sID
   having count(distinct major) > 2);


delete from Apply
where sID in
  (select sID
   from Apply
   group by sID
   having count(distinct major) > 2);

/**************************************************************
  Delete colleges with no CS applicants
**************************************************************/

delete from College
where cName not in (select cName from Apply where major = 'CS');

/**************************************************************
  Accept applicants to Carnegie Mellon with GPA < 3.6 but turn
  them into economics majors
**************************************************************/

update Apply
set decision = 'Y', major = 'economics'
where cName = 'Carnegie Mellon'
  and sID in (select sID from Student where GPA < 3.6);

/**************************************************************
  Turn the highest-GPA EE applicant into a CSE applicant
**************************************************************/

update Apply
set major = 'CSE'
where major = 'EE'
  and sID in
    (select sID from Student
     where GPA >= all
        (select GPA from Student
         where sID in (select sID from Apply where major = 'EE')));

/**************************************************************
  Give everyone the highest GPA and smallest HS
**************************************************************/

update Student
set GPA = (select max(GPA) from Student),
    sizeHS = (select min(sizeHS) from Student);

/**************************************************************
  Accept everyone
**************************************************************/

update Apply
set decision = 'Y';
