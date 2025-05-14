SELECT fest.festival_name, loc.year, SUM(tick.ticket_price) as total_price, tick.ticket_way_of_purchase
FROM festival fest
INNER JOIN location loc
ON loc.festival_id = fest.festival_id
INNER JOIN event ev
ON ev.location_id = loc.location_id
INNER JOIN ticket tick
ON tick.event_id = ev.event_id
GROUP BY loc.year, fest.festival_name, tick.ticket_way_of_purchase;