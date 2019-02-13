# 1. Add the reviewer Roger Ebert to your database, with an rID of 209.

insert into reviewer
values (209, "Roger Ebert");



# 2. Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL. 

INSERT INTO rating
(
    rid, stars, mid
)
SELECT
	(
        SELECT rev.rid
        FROM reviewer AS rev
        WHERE rev.name = 'James Cameron'
    ),
    5,
    mov.mid
FROM movie AS mov
ORDER BY mov.mid ASC;

# 3. For all movies that have an average rating of 4 stars or higher, add 25 to the release year. 
#    (Update the existing tuples; don't insert new tuples.)

update movie
set year= year + 25
where movie.mID in
(select M.mID
from movie M, rating R
where M.mId=R.mID
group by M.mId
having avg(stars) >=4);

# 4. Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars. 

delete from rating
where 
rating.mID in
(select M.mID
from movie M
where M.year < 1970 or M.year > 2000)
and rating.stars < 4;










