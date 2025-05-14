SELECT LEAST(gen_1.genre, gen_2.genre) as genre_1, GREATEST(gen_1.genre, gen_2.genre) as genre_2, (count(perf.performance_id)) DIV 2 as appearances
FROM genre gen_1
INNER JOIN genre gen_2
ON gen_1.artist_id = gen_2.artist_id AND gen_1.genre != gen_2.genre
INNER JOIN artist art
ON gen_2.artist_id = art.artist_id
INNER JOIN performance perf
ON perf.artist_id = art.artist_id
GROUP BY genre_1, genre_2
ORDER BY appearances DESC
LIMIT 3;


