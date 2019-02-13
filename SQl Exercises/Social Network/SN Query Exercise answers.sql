select * from Highschooler;

select * from Friend;

select * from Likes;

# Q1: - Find the names of all students who are friends with someone named Gabriel.

select name from Highschooler
where ID in
(select ID2
from Highschooler H, Friend F
where H.ID=F.ID1 and name="Gabriel");

# Q2: - For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, 
#       and the name and grade of the student they like. 

select H1.name, H1.grade, H2.name, H2.grade from
from Highschooler AS H1, Highschooler AS H2, Likes AS L
Where (H1.ID=L.ID1 and H2.ID=L.ID2 and H1.grade - H2.grade >=2)
or
(H1.ID=L.ID2 and H2.ID=L.ID1 and H1.grade - H2.grade >=2);

SELECT hs1.name, hs1.grade, hs2.name, hs2.grade
FROM highschooler AS hs1, highschooler AS hs2, likes AS l
WHERE
(
    hs1.id = l.id1
    AND l.id2 = hs2.id
    AND hs1.grade - hs2.grade >= 2
)
OR
(
    hs1.id = l.id2
    AND l.id1 = hs2.id
    AND hs1.grade - hs2.grade >= 2
);


# Q3: - For every pair of students who both like each other, return the name and grade of both students. 
#       Include each pair only once, with the two names in alphabetical order.

select distinct H1.name, H1.grade, H2.name, H2.grade
from Likes L1, Likes L2, Highschooler H1, Highschooler H2
where (H1.ID=L1.ID1 and H2.ID=L1.ID2)
and
 (H1.ID=L2.ID2 and H2.ID=L2.ID1)
 and 
 (H1.name < H2.name)
;

# Q4: - Find all students who do not appear in the Likes table (as a student who likes or is liked) and 
#       return their names and grades. Sort by grade, then by name within each grade.

select distinct name, grade from
Highschooler
where ID not IN
(select H1.ID from 
Highschooler H1, Likes L1
where H1.ID=L1.ID1)
and
ID not IN
(select H2.ID from 
Highschooler H2, Likes L2
where H2.ID=L2.ID2)
order by grade, name;


# Q5: - For every situation where student A likes student B, but we have no information about whom B likes 
#       (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades. 

SELECT DISTINCT hs1.name, hs1.grade, hs2.name, hs2.grade
FROM highschooler AS hs1, highschooler AS hs2, likes AS l
WHERE
(
    hs1.id = l.id1
    AND hs2.id = l.id2
    AND hs2.id NOT IN
    (SELECT id1 FROM likes)
);


# Q6: - Find names and grades of students who only have friends in the same grade. 
#       Return the result sorted by grade, then by name within each grade. 

select distinct H1.name, H1.grade 
from Highschooler H1, Highschooler H2, Friend F1
where H1.ID=F1.ID1 and H2.ID=F1.ID2 and
H1.ID not in 
(
select H1.ID from Highschooler H1, Highschooler H2, Friend F1
where H1.ID=F1.ID1 and H2.ID=F1.ID2
and H1.grade != H2.grade
)
order by H1.grade, H1.name;


# Q7: - For each student A who likes a student B where the two are not friends, 
#       find if they have a friend C in common (who can introduce them!). For all such trios, 
#       return the name and grade of A, B, and C.

select distinct H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade from
from highschooler H1, highschooler H2, highschooler H3, likes L1, friend F1
where H1.ID=L1.ID1 and H2.ID=L1.ID2 
and H1.ID not in 
(
select F2.ID2 
from Friend F2
where F2.ID1=H2.ID
)
and H3.ID in 
(
select F2.ID2 
from Friend F2
where F2.ID1=H1.ID
)
and H3.ID in 
(
select F2.ID2 
from Friend F2
where F2.ID1=H2.ID
)
;

SELECT DISTINCT hs1.name, hs1.grade, hs2.name, hs2.grade, hs3.name, hs3.grade
FROM highschooler AS hs1, highschooler AS hs2, highschooler AS hs3, friend AS f, likes AS l
WHERE hs1.id = l.id1
AND hs2.id = l.id2
AND hs1.id NOT IN
(
    SELECT friend.id2
    FROM friend
    WHERE friend.id1 = hs2.id
)
AND hs3.id IN
(
    SELECT friend.id2
    FROM friend
    WHERE friend.id1 = hs1.id
)
AND hs3.id IN
(
    SELECT friend.id2
    FROM friend
    WHERE friend.id1 = hs2.id
);

# Q8: - Find the difference between the number of students in the school and the number of different first names. 

select count(*) as Same
from highschooler H1, highschooler H2
where H1.ID<H2.ID and H1.name=H2.name;

select count(*)
-
(select count(distinct H.name)
from highschooler H) 
 DIFF
 from highschooler;

# Q9: - Find the name and grade of all students who are liked by more than one other student. 

select name,grade
from Highschooler H, Likes L
where H.ID=L.ID2
group by L.ID2
having count(*) > 1;










