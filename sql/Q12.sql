SELECT fest.festival_name, ev.day, count(IF(st.role = 'technical', 1, NULL)) as security_staff, count(IF(st.role = 'helper', 1, NULL)) as helpers_staff
FROM staff st
INNER JOIN building build
ON build.building_id = st.building_id
INNER JOIN event ev
ON ev.building_id = build.building_id
INNER JOIN location loc
ON ev.location_id = loc.location_id
INNER JOIN festival fest
ON loc.festival_id = fest.festival_id
GROUP BY fest.festival_name, ev.day;