SELECT vis.visitor_id, vis.visitor_name, vis.visitor_surname, art.name as artist_name, SUM(rat.rating_artist_performance) as total_artist_rating
FROM rating rat
INNER JOIN ticket tick
ON rat.rating_id = tick.rating_id
INNER JOIN event ev
ON ev.event_id = tick.event_id
INNER JOIN performance perf
ON perf.event_id = ev.event_id
INNER JOIN artist art
ON perf.artist_id = art.artist_id
INNER JOIN visitor vis
ON vis.visitor_id = tick.visitor_id
GROUP BY vis.visitor_id, art.name
ORDER BY total_artist_rating DESC, vis.visitor_id
LIMIT 5;