SELECT art.name, art.nickname, art.date_of_birth, art.social_media
FROM artist art
INNER JOIN performance perf
ON art.artist_id = perf.artist_id
INNER JOIN event ev
ON perf.event_id = ev.event_id
INNER JOIN location loc
ON ev.location_id = loc.location_id
GROUP BY art.name
HAVING count(DISTINCT loc.continent) >= 3;