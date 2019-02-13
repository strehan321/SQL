#1. Find the names of all reviewers who rated Gone with the Wind. 

select distinct name from Reviewer R, Movie M, Rating Rt
where R.rId=Rt.rId and M.mid= Rt.mID
and title="Gone with the Wind" and stars is not NULL;

# 2. For any rating where the reviewer is the same as the director of the movie, 
#    return the reviewer name, movie title, and number of stars.

select name, title, stars from
Movie M, Rating R, Reviewer Rv 
where M.mid=R.mId
and Rv.rId= R.rId
and name=director;

# 3. Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer 
#    and first word in the title is fine; no need for special processing on last names or removing "The".) 

select list from
(select title as list
from movie
UNION
select name as list
from reviewer) T
order by list;  

# 4. Find the titles of all movies not reviewed by Chris Jackson. 

select title from movie
where mID not in
(select mID from Rating where rID in
(select rId from Reviewer 
where name = "Chris Jackson"));

# 5. For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. 
#    Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the 
#    names in the pair in alphabetical order. 

select distinct r3.name as rname1, r4.name as rname2
from Rating R1, Rating R2, reviewer R3, reviewer R4
where R3.name <> R4.name and R1.mID= R2.mID and R3.name < R4.name
and R1.rID=R3.rID and R2.rId=R4.rID
order by rname1, rname2;

# 6. For each rating that is the lowest (fewest stars) currently in the database, 
#    return the reviewer name, movie title, and number of stars.

select name, title, stars from
Movie M, Rating R, Reviewer Rv 
where M.mid=R.mId
and Rv.rId= R.rId
and stars = (select min(stars) from rating);

# 7. List movie titles and average ratings, from highest-rated to lowest-rated. 
#    If two or more movies have the same average rating, list them in alphabetical order. 

select title, avg(stars) 
from Movie M, Rating R
where M.mID=R.mID
group by M.mID
order by avg(stars) desc, title;

# 8. Find the names of all reviewers who have contributed three or more ratings. 
#    (As an extra challenge, try writing the query without HAVING or without COUNT.) 

select name from reviewer R, rating Rt
where R.rID=Rt.rId
group by name
having count(*) >=3;

# 9. Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, 
#    along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query 
#    both with and without COUNT.) 

select title, director from movie
where director in
(select director from movie
group by director
having count(*) >1)
order by director, title;

# 10. Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. 
#     (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as 
#     finding the highest average rating and then choosing the movie(s) with that average rating.)


select M.title, avg(R.stars)
from movie M, rating R
where M.mID=R.mID 
group by M.mID
having avg(R.stars)=
(
select max(AVG)
from
(select mId, avg(stars) as AVG from
Rating group by mID) As avg_table
);

# 11. Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. 
#     (Hint: This query may be more difficult to write in SQLite than other systems; you might think of 
#      it as finding the lowest average rating and then choosing the movie(s) with that average rating.)

select M.title, avg(R.stars)
from movie M, rating R
where M.mID=R.mID 
group by M.mID
having avg(R.stars)=
(
select min(AVG)
from
(select mId, avg(stars) as AVG from
Rating group by mID) As avg_table
);

# 12. For each director, return the director's name together with the title(s) of the movie(s) they directed that 
#     received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. 

select distinct M1.director, M1.title, R1.stars
from movie M1, rating R1
where M1.mID=R1.mID and director is not null
and R1.stars in
(select max(R2.stars)
from movie M2, rating R2
where M2.mID=R2.mID
and m2.director is not null
and m1.director=m2.director
);






















