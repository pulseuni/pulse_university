SELECT DISTINCT name, nickname, date_of_birth, social_media, festival_id FROM (
	SELECT art.name as name, art.nickname as nickname, art.date_of_birth as date_of_birth, art.social_media as social_media, fest.festival_id as festival_id,
        ROW_NUMBER() OVER (PARTITION BY art.name, art.nickname, art.date_of_birth, art.social_media, fest.festival_id ORDER BY fest.festival_id) as count
	FROM artist art
	LEFT JOIN performance perf
	ON art.artist_id = perf.artist_id
	LEFT JOIN event ev
	ON perf.event_id = ev.event_id
	LEFT JOIN location loc
	ON ev.location_id = loc.location_id
	LEFT JOIN festival fest
	ON loc.festival_id = fest.festival_id
	WHERE perf.performance_type = 'Warmup'
) as count_table
WHERE count > 2;