SELECT festival_location, average_experience as experience FROM (
	SELECT fest.festival_name as festival_location, avg(st.staff_experience) as average_experience
	FROM staff st
	INNER JOIN building build
	ON st.building_id = build.building_id
	INNER JOIN event ev
	ON build.building_id = ev.building_id
	LEFT JOIN location loc
	ON ev.location_id = loc.location_id
	LEFT JOIN festival fest
	ON loc.festival_id = fest.festival_id
	WHERE st.role = 'technical'
	GROUP BY fest.festival_name
) as experience_table_1
WHERE average_experience = (
	SELECT MIN(average_experience) FROM (
		SELECT fest.festival_name as festival_location, avg(st.staff_experience) as average_experience
		FROM staff st
		INNER JOIN building build
		ON st.building_id = build.building_id
		INNER JOIN event ev
		ON build.building_id = ev.building_id
		LEFT JOIN location loc
		ON ev.location_id = loc.location_id
		LEFT JOIN festival fest
		ON loc.festival_id = fest.festival_id
		WHERE st.role = 'technical'
		GROUP BY fest.festival_name
	) as experience_table_2
);

