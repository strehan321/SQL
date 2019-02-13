# Q1: - It's time for the seniors to graduate. Remove all 12th graders from Highschooler. 

delete from highschooler 
where grade="12";

# Q2: - If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple. 

delete from likes
where likes.ID1 IN
(
select ID2 from friend F1
where F1.ID1= likes.ID2
)
and likes.ID2 in
(
select L.ID2 from likes L
where L.ID1= likes.ID1
)
and likes.ID1 NOT IN
(
select L.ID2
from Likes L 
where L.ID1=Likes.ID2
)
;

# Q3: - For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. 
#       Do not add duplicate friendships, friendships that already exist, or friendships with oneself. 
#       (This one is a bit challenging; congratulations if you get it right.) 


INSERT INTO friend (id1, id2)
SELECT DISTINCT f1.id1 AS id1, f3.id1 AS id2
FROM friend AS f1, friend AS f2, friend AS f3
WHERE f2.id1 IN
(
    SELECT friend.id2
    FROM friend
    WHERE friend.id1 = f1.id1
)
AND f2.id1 IN
(
    SELECT friend.id2
    FROM friend
    WHERE friend.id1 = f3.id1
)
AND f3.id1 NOT IN
(
    SELECT friend.id2
    FROM friend
    WHERE friend.id1 = f1.id1
)
AND f1.id1 != f3.id1;























