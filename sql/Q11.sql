SELECT name, nickname, date_of_birth, social_media, appearances FROM (
	SELECT art.name as name, art.nickname as nickname, art.date_of_birth as date_of_birth, art.social_media as social_media, count(fest.festival_id) as appearances
	FROM artist art
	LEFT JOIN performance perf
	ON art.artist_id = perf.artist_id
	LEFT JOIN event ev
	ON perf.event_id = ev.event_id
	LEFT JOIN location loc
	ON ev.location_id = loc.location_id
	LEFT JOIN festival fest
	ON loc.festival_id = fest.festival_id
	GROUP BY art.name
	ORDER BY appearances DESC
) as appearances_table_1
WHERE appearances <= (
	SELECT MAX(appearances) - 5 FROM (
		SELECT art.name as name, art.nickname as nickname, art.date_of_birth as date_of_birth, art.social_media as social_media, count(fest.festival_id) as appearances
		FROM artist art
		LEFT JOIN performance perf
		ON art.artist_id = perf.artist_id
		LEFT JOIN event ev
		ON perf.event_id = ev.event_id
		LEFT JOIN location loc
		ON ev.location_id = loc.location_id
		LEFT JOIN festival fest
		ON loc.festival_id = fest.festival_id
		GROUP BY art.name
	) as appearances_table_2
);