SELECT st.staff_name, st.staff_age, st.staff_experience, st.role, ev.day
FROM staff st
INNER JOIN building build
ON st.building_id = build.building_id
INNER JOIN event ev
ON ev.building_id = build.building_id
WHERE ev.day != '2026-04-22';