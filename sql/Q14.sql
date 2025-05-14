WITH type as (
	SELECT gen.genre as genre, count(perf.performance_id) as appearances, loc.year as year
	FROM genre gen
	INNER JOIN artist art
	ON gen.artist_id = art.artist_id
	INNER JOIN performance perf
	ON art.artist_id = perf.artist_id
	INNER JOIN event ev
	ON perf.event_id = ev.event_id
	INNER JOIN location loc
	ON ev.location_id = loc.location_id
	GROUP BY loc.year, gen.genre
	HAVING appearances >= 3	
)
SELECT type_1.*, type_2.* 
FROM type type_1
INNER JOIN type type_2
ON (type_1.genre = type_2.genre) AND (type_1.appearances = type_2.appearances) AND (type_1.year = type_2.year - 1); 
