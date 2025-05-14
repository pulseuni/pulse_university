SELECT art.name, art.nickname, art.date_of_birth, gen.genre, gen.subgenre, art.social_media, IF(count(IF(loc.year = 2025, 1, NULL)) > 0, 'True', 'False') as appeared
FROM genre gen
INNER JOIN artist art
ON gen.artist_id = art.artist_id
LEFT JOIN performance perf
ON art.artist_id = perf.artist_id
LEFT JOIN event ev
ON perf.event_id = ev.event_id
LEFT JOIN location loc
ON ev.location_id = loc.location_id
WHERE gen.genre = 'Metal'
GROUP BY art.name;
