SELECT vis.visitor_id, vis.visitor_name, vis.visitor_surname, ev.event_name, ev.event_id, (rating_sound_and_audio + rating_stage_presence + rating_organization + rating_overall + rating_artist_performance)/5 as average_rating
FROM rating rat
INNER JOIN ticket tick
ON rat.rating_id = tick.rating_id
INNER JOIN event ev
ON ev.event_id = tick.event_id
INNER JOIN visitor vis
ON tick.visitor_id = vis.visitor_id
WHERE vis.visitor_id = 2;

