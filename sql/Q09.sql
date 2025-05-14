WITH visited as (
	SELECT vis.visitor_id as visitor_id, vis.visitor_name as visitor_name, vis.visitor_surname as visitor_surname, count(ev.event_id) as events_seen, loc.year as year
	FROM visitor vis
	INNER JOIN ticket tick
	ON tick.visitor_id = vis.visitor_id
	INNER JOIN event ev
	ON ev.event_id = tick.event_id
	INNER JOIN location loc
	ON ev.location_id = loc.location_id
	GROUP BY vis.visitor_id, loc.year
	HAVING events_seen > 3
)
SELECT visited_1.*, visited_2.*
FROM visited visited_1
INNER JOIN visited visited_2
ON visited_1.visitor_id != visited_2.visitor_id
WHERE visited_1.events_seen = visited_2.events_seen;