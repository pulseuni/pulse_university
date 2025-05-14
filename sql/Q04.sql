SELECT art.name, avg(rat.rating_artist_performance) as average_artist_rating, avg(rat.rating_overall) as average_overall_rating
FROM rating rat
INNER JOIN ticket tick
ON rat.rating_id = tick.rating_id
INNER JOIN event ev
ON ev.event_id = tick.event_id
INNER JOIN performance perf
ON perf.event_id = ev.event_id
INNER JOIN artist art
ON perf.artist_id = art.artist_id
WHERE art.name = 'Sara Jones'
GROUP BY art.name;