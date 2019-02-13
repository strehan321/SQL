select * from Movie;

# 1 : Find the titles of all movies directed by Steven Spielberg. 

select title from Movie 
where director="Steven Spielberg";

# 2 : Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. 

select year from Movie 
where mID in 
(select mID from Rating where stars = 4 or stars=5)
order by year;

# 3. Find the titles of all movies that have no ratings. 

select title from Movie 
left join Rating using (mID)
where stars is NULL;

# 4. Some reviewers didn't provide a date with their rating. 
#    Find the names of all reviewers who have ratings with a NULL value for the date. 

select name
from Reviewer left join Rating using (rID)
where ratingDate is NULL;

# 5. Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. 
#    Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. 

select name as reviewername, title as movietitle, stars, ratingDate
from Rating join Reviewer using (rID) join Movie using (mID)
order by reviewername, movietitle, stars;

# 6. For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, 
#    return the reviewer's name and the title of the movie. 

select * 
from 
((select T.rId, T.mId, stars, ratingDate As stars
from 
(select rId, mID, stars, ratingdate from rating 
where rId IN
(select rID from rating
group by rId, mId
having count(stars)=2)
and mID in
(select mID from rating
group by rId, mId
having count(stars)=2)) T
group by T.rId, T.mID)) D, Movie M, Reviewer R
where M.mId= D.miD and R.rId=d.rId;



SELECT r.name, m.title
FROM movie m, reviewer r,
  (
    SELECT r1.rid, r1.mid
    FROM rating r1, rating r2
    WHERE r1.rid = r2.rid AND r1.mid = r2.mid
    AND r1.stars > r2.stars
    AND r1.ratingdate > r2.ratingdate
  ) AS a
WHERE m.mid = a.mid AND r.rid = a.rid;


# 7 : For each movie that has at least one rating, find the highest number of stars that movie received. 
#     Return the movie title and number of stars. Sort by movie title. 

select title, max(stars)
from Movie, Rating
where Movie.mId= Rating.mId
group by Movie.mID
having count(stars) >=1;

# 8. : For each movie, return the title and the 'rating spread', that is, the difference between highest 
#      and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title.

select title, (max(stars) - min(stars)) As RatingSpread
from Movie, Rating
where Movie.mId= Rating.mId
group by Movie.mID
having count(stars) >=1
order by RatingSpread DESC, title;

# 9. Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. 
#    (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 
#    and movies after. Don't just calculate the overall average rating before and after 1980.)

select avg1.A1 - avg2.A2
from 
(select avg(AVG) A1
from 
(select title, avg(stars) AVG, year
from Movie, Rating
where Movie.mId= Rating.mId
group by Movie.mID) avg
where year < 1980) avg1,
(select avg(AVG) A2
from 
(select title, avg(stars) AVG, year
from Movie, Rating
where Movie.mId= Rating.mId
group by Movie.mID) avg
where year > 1980) avg2;


