CREATE DATABASE pulse_university;
USE pulse_university;

CREATE TABLE festival (
	festival_id int(5) AUTO_INCREMENT NOT NULL,
	festival_name varchar(50) NOT NULL,
	duration int(2) NOT NULL,
	image varchar(2000) NOT NULL,
	image_caption varchar(100) NOT NULL, 	
	PRIMARY KEY(festival_id)
	);

CREATE TABLE event (
	event_id int(5) AUTO_INCREMENT NOT NULL,
	event_name varchar(50) NOT NULL,
	day DATE NOT NULL,
	PRIMARY KEY(event_id)
	);

	
CREATE TABLE building (
	building_id int(5) AUTO_INCREMENT NOT NULL,
	building_name varchar(50) NOT NULL,
	description varchar(100) NOT NULL,
	max_capacity int(10) NOT NULL,
	info varchar(100) NOT NULL,
	PRIMARY KEY(building_id)
	);

CREATE TABLE performance (
	performance_id int(5) AUTO_INCREMENT NOT NULL,
	performance_type varchar(50) NOT NULL,
	performance_time int(5) NOT NULL,
	duration numeric(3, 2) NOT NULL,
	break int(5) NOT NULL,
	PRIMARY KEY(performance_id)
	);
	

CREATE TABLE artist (
	artist_id int(5) AUTO_INCREMENT NOT NULL,
	name varchar(50) NOT NULL,
	nickname varchar(50),
	date_of_birth DATE NOT NULL,
	social_media varchar(50),
	PRIMARY KEY(artist_id)
	);

CREATE TABLE genre (
	genre_id int(5) AUTO_INCREMENT NOT NULL,
	genre varchar(50) NOT NULL,
	subgenre varchar(50),
        artist_id int(5) NOT NULL,
	PRIMARY KEY(genre_id),
	CONSTRAINT fk_genre_1 FOREIGN KEY(artist_id) REFERENCES artist(artist_id)
);


CREATE TABLE band (
    band_id int(5) AUTO_INCREMENT NOT NULL,
    band_name varchar(50) NOT NULL,
    type_of_music varchar(50) NOT NULL,
    subtype_of_music varchar(50),
    date_of_creation varchar(10) NOT NULL,
    website varchar(50),
    PRIMARY KEY(band_id)
);
	

ALTER TABLE performance
ADD artist_id int(5);
ALTER TABLE performance 
ADD CONSTRAINT fk_performance_1 FOREIGN KEY(artist_id) REFERENCES artist(artist_id);

ALTER TABLE performance
ADD event_id int(5) NOT NULL;
ALTER TABLE performance 
ADD CONSTRAINT fk_performance_2 FOREIGN KEY(event_id) REFERENCES event(event_id);

ALTER TABLE performance
ADD band_id int(5);
ALTER TABLE performance 
ADD CONSTRAINT fk_performance_3 FOREIGN KEY(band_id) REFERENCES band(band_id);

CREATE TABLE location (
	location_id int(5) AUTO_INCREMENT NOT NULL,
	address varchar(50) NOT NULL,
	cords varchar(50) NOT NULL,
	city varchar(50) NOT NULL,
	country varchar(50) NOT NULL,
	continent varchar(50) NOT NULL,
	year int(4) NOT NULL,
	festival_id int(5) NOT NULL,
	PRIMARY KEY(location_id),
	CONSTRAINT fk_location_1 FOREIGN KEY(festival_id) REFERENCES festival(festival_id)
	);

CREATE TABLE band_artist (
	artist_id int(5) NOT NULL,
	band_id int(5) NOT NULL,
	PRIMARY KEY (artist_id, band_id),
	CONSTRAINT fk_band_artist_1 FOREIGN KEY(artist_id) REFERENCES artist(artist_id),
	CONSTRAINT fk_band_artist_2 FOREIGN KEY(band_id) REFERENCES band(band_id)
	);





CREATE TABLE ticket(
	ticket_id int(5) AUTO_INCREMENT NOT NULL,
	ticket_day_of_purchase DATE NOT NULL,
	ticket_way_of_purchase varchar(50) NOT NULL,
	ticket_barcode bigint NOT NULL,
	ticket_is_active boolean NOT NULL,
	ticket_type varchar(50) NOT NULL,
	ticket_price int(4) NOT NULL,   
	event_id int(5) NOT NULL,
	CONSTRAINT fk_ticket_1 FOREIGN KEY(event_id) REFERENCES event(event_id),
	PRIMARY KEY(ticket_id)
	);

CREATE TABLE visitor(
	visitor_id int(5) AUTO_INCREMENT NOT NULL,
	visitor_name varchar(50) NOT NULL,
	visitor_surname varchar(50) NOT NULL,
	visitor_phone_number bigint NOT NULL,
	visitor_email varchar(50) NOT NULL,
	visitor_age int(3) NOT NULL,
        wanting_to_sell boolean,
	PRIMARY KEY(visitor_id)
	);

CREATE TABLE reselling_queue (
    reselling_queue_id int(5) AUTO_INCREMENT,
    ticket_id int(5),
    event_id int(5),
    seller_id int(5),
    buyer_id int(5),
    queue_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_reselling_queue_1 FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id),
    CONSTRAINT fk_reselling_queue_2 FOREIGN KEY (event_id) REFERENCES event(event_id),
    CONSTRAINT fk_reselling_queue_3 FOREIGN KEY (seller_id) REFERENCES visitor(visitor_id),
    CONSTRAINT fk_reselling_queue_4 FOREIGN KEY (buyer_id) REFERENCES visitor(visitor_id),
    PRIMARY KEY(reselling_queue_id)
);

CREATE TABLE rating(
	rating_id int(5) NOT NULL AUTO_INCREMENT,
	rating_sound_and_audio int(2) NOT NULL,
	rating_stage_presence int(2) NOT NULL,
	rating_organization int(2) NOT NULL,
	rating_overall int(2) NOT NULL,
	rating_artist_performance int(2) NOT NULL,
	PRIMARY KEY(rating_id)
	);


ALTER TABLE event
ADD location_id int(5) NOT NULL;

ALTER TABLE event
ADD CONSTRAINT fk_event_1 FOREIGN KEY(location_id) REFERENCES location(location_id);

ALTER TABLE event
ADD building_id int(5) NOT NULL;

ALTER TABLE event
ADD CONSTRAINT fk_event_2 FOREIGN KEY(building_id) REFERENCES building(building_id);

ALTER TABLE ticket
ADD rating_id int(5);

ALTER TABLE ticket
ADD CONSTRAINT fk_ticket_2 FOREIGN KEY(rating_id) REFERENCES rating(rating_id); 

ALTER TABLE ticket
ADD visitor_id int(5) NOT NULL;

ALTER TABLE ticket
ADD CONSTRAINT fk_ticket_3 FOREIGN KEY(visitor_id) REFERENCES visitor(visitor_id); 


CREATE TABLE equipment (
	equipment_id int(5) AUTO_INCREMENT NOT NULL,
	speakers varchar(50) NOT NULL,
	lights varchar(50) NOT NULL,
	microphones varchar(50) NOT NULL,
	console varchar(50) NOT NULL,
	special_effects varchar(50) NOT NULL,
	PRIMARY KEY(equipment_id)
	);

ALTER TABLE building
ADD equipment_id int(5) NOT NULL;

ALTER TABLE building
ADD CONSTRAINT fk_building_1 FOREIGN KEY(equipment_id) REFERENCES equipment(equipment_id);


CREATE TABLE staff(
	staff_id int(5) AUTO_INCREMENT NOT NULL,
	staff_name varchar(50) NOT NULL,
	staff_age int(3) NOT NULL,
	staff_experience int(2) NOT NULL,
	building_id int(5) NOT NULL,
	role varchar(50) NOT NULL,
	PRIMARY KEY(staff_id),
	CONSTRAINT fk_staff_1 FOREIGN KEY(building_id) REFERENCES building(building_id)
	);


CREATE TABLE buyers(
	buyer_id int(5) NOT NULL,
	buyer_name varchar(50) NOT NULL,
	buyer_surname varchar(50) NOT NULL,
	buyer_phone_number bigint NOT NULL,
	buyer_email varchar(50) NOT NULL,
	buyer_age int(3) NOT NULL,
	event_id int(5) NOT NULL,
	PRIMARY KEY(buyer_id),
	CONSTRAINT fk_buyer_1 FOREIGN KEY(event_id) REFERENCES event(event_id)
	);











/* This checks that only one festival can happen at a location per year */
ALTER TABLE location
ADD CONSTRAINT unique_location_per_year UNIQUE(city, year);

/* This checks that a break is between 5 and 30 minutes */
ALTER TABLE performance
ADD CONSTRAINT chk_break CHECK (break BETWEEN 5 AND 30);

/* This checks that a performance is less than 3 hours */
ALTER TABLE performance
ADD CONSTRAINT chk_duration CHECK (duration BETWEEN 0 AND 3);



CREATE INDEX idx_genre ON genre(genre);

CREATE INDEX idx_artist_name ON artist(name);
CREATE INDEX idx_artist_date_of_birth ON artist(date_of_birth);

CREATE INDEX idx_performance_type ON performance(performance_type);

CREATE INDEX idx_staff_role ON staff(role);

CREATE INDEX idx_festival_name ON festival(festival_name);

CREATE INDEX idx_event_day ON event(day);






DELIMITER $$


/* This trigger checks that a band cannot appear on many performances at hte same time */

CREATE TRIGGER prevent_band_double_booking
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
	DECLARE conflicting_count INT;

	SELECT COUNT(*) INTO conflicting_count
	FROM performance
	WHERE band_id = NEW.band_id
		AND ((NEW.performance_time BETWEEN performance_time AND performance_time + duration) OR
		(performance_time BETWEEN NEW.performance_time AND NEW.performance_time + NEW.duration));

	IF conflicting_count > 0 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'This band is already performing at that time.';
	END IF;

END$$


/* This trigger checks that a band cannot perform for more than 3 consecutive years */

CREATE TRIGGER prevent_band_consecutive_years
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
	DECLARE band_year INT;
	DECLARE y1 INT; DECLARE y2 INT; DECLARE y3 INT; DECLARE y4 INT;

	SELECT l.year INTO band_year
	FROM event e
	JOIN location l ON e.location_id = l.location_id
	WHERE e.event_id = NEW.event_id;

	SELECT 
		MAX(CASE WHEN l.year = band_year - 1 THEN 1 ELSE 0 END) AS y1,
		MAX(CASE WHEN l.year = band_year - 2 THEN 1 ELSE 0 END) AS y2,
		MAX(CASE WHEN l.year = band_year - 3 THEN 1 ELSE 0 END) AS y3,
		MAX(CASE WHEN l.year = band_year - 4 THEN 1 ELSE 0 END) AS y4
	INTO y1, y2, y3, y4
	FROM performance p
	JOIN event e ON p.event_id = e.event_id
	JOIN location l ON e.location_id = l.location_id
	WHERE p.band_id = NEW.band_id;

	IF y1 = 1 AND y2 = 1 AND y3 = 1 THEN
    		SIGNAL SQLSTATE '45000'
    		SET MESSAGE_TEXT = 'Band cannot perform for more than 3 consecutive years.';
	END IF;

END$$


CREATE TRIGGER prevent_artist_double_booking
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
    DECLARE new_start INT;
    DECLARE new_end INT;
    DECLARE overlap_count INT;

    IF NEW.artist_id IS NOT NULL THEN
        SET new_start = NEW.performance_time;
        SET new_end = NEW.performance_time + NEW.duration;

        SELECT COUNT(*) INTO overlap_count
        FROM performance p
        WHERE p.artist_id = NEW.artist_id
          AND ((new_start < (p.performance_time + p.duration)) 
          AND (new_end > p.performance_time));

        IF overlap_count > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'This artist is already booked for another performance at overlapping times.';
        END IF;
    END IF;

END$$

CREATE TRIGGER prevent_artist_consecutive_years
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
    DECLARE new_year INT;
    DECLARE count_consecutive INT;

    IF NEW.artist_id IS NOT NULL THEN
        -- Get the year of the new performance
        SELECT l.year INTO new_year
        FROM event e
        JOIN location l ON e.location_id = l.location_id
        WHERE e.event_id = NEW.event_id;

        -- Count how many of the past 3 years (excluding current) this artist has performed
        SELECT COUNT(DISTINCT l.year) INTO count_consecutive
        FROM performance p
        JOIN event e ON p.event_id = e.event_id
        JOIN location l ON e.location_id = l.location_id
        WHERE p.artist_id = NEW.artist_id
          AND l.year BETWEEN new_year - 3 AND new_year - 1;

        -- If performed in all 3 previous years, block insert
        IF count_consecutive = 3 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'This artist cannot participate in more than 3 consecutive years.';
        END IF;
    END IF;

END$$


CREATE TRIGGER check_ticket_capacity
BEFORE INSERT ON ticket
FOR EACH ROW
BEGIN
	DECLARE eventBuilding INT;
	DECLARE buildingCapacity INT;
	DECLARE soldTickets INT;

	SELECT building_id 
	INTO eventBuilding
	FROM event
	WHERE event_id = NEW.event_id;

	SELECT max_capacity 
	INTO buildingCapacity
	FROM building
	WHERE building_id = eventBuilding;

	SELECT COUNT(*) INTO soldTickets
	FROM ticket
	WHERE event_id = NEW.event_id;

	IF soldTickets + 1 > buildingCapacity THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Cannot sell ticket: building capacity exceeded.';
	END IF;

END$$



CREATE TRIGGER check_vip_ticket_limit
BEFORE INSERT ON ticket
FOR EACH ROW
BEGIN
	DECLARE buildingID INT;
	DECLARE capacity INT;
	DECLARE currentVIPCount INT;

    	IF NEW.ticket_type = 'VIP' THEN

        	SELECT building_id
        	INTO buildingID
        	FROM event
        	WHERE event_id = NEW.event_id;

        	SELECT max_capacity INTO capacity
        	FROM building
        	WHERE building_id = buildingID;

        	SELECT COUNT(*) INTO currentVIPCount
        	FROM ticket t
        	JOIN event e ON t.event_id = e.event_id
		WHERE t.ticket_type = 'VIP' AND e.building_id = buildingID;

        	IF currentVIPCount + 1 > (capacity * 0.10) THEN
            		SIGNAL SQLSTATE '45000'
            		SET MESSAGE_TEXT = 'VIP ticket limit (10% of stage capacity) exceeded';
        	END IF;
	END IF;
END$$



/* This is for checking that the same festival doesn't happen on the same location for two consecutive years before inserting data*/


CREATE TRIGGER check_consecutive_year_location_insert
BEFORE INSERT ON location
FOR EACH ROW
BEGIN
    DECLARE conflict_count INT;

    SELECT COUNT(*) INTO conflict_count
    FROM location
    WHERE city = NEW.city 
      AND ((year = NEW.year - 1 OR year = NEW.year + 1)
      AND (festival_id = NEW.festival_id));

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Festival locations must skip at least one year before being reused.';
    END IF;
END$$


/* This is for checking that the same festival doesn't happen on the same location for two consecutive years before updating data*/

CREATE TRIGGER check_consecutive_year_location_update
BEFORE UPDATE ON location
FOR EACH ROW
BEGIN
    DECLARE conflict_count INT;

    SELECT COUNT(*) INTO conflict_count
    FROM location
    WHERE city = NEW.city
      AND ((year = NEW.year - 1 OR year = NEW.year + 1) 
      AND (festival_id = NEW.festival_id)
      AND (location_id <> NEW.location_id));

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Festival locations must skip at least one year before being reused.';
    END IF;

END$$


/* This is for checking that no performances overlap */

CREATE TRIGGER check_performance_schedule
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
    DECLARE new_start INT;
    DECLARE new_end INT;
    DECLARE overlap_count INT;

    SET new_start = NEW.performance_time;
    SET new_end = NEW.performance_time + NEW.duration + NEW.break;

    SELECT COUNT(*) INTO overlap_count
    FROM performance p
    JOIN event e1 ON p.event_id = e1.event_id
    JOIN event e2 ON NEW.event_id = e2.event_id
    WHERE e1.building_id = e2.building_id
      AND (
        (p.performance_time <= new_start AND new_start <= (p.performance_time + p.duration + p.break))
        OR (p.performance_time <= new_end AND new_end <= (p.performance_time + p.duration + p.break))
        OR (new_start <= p.performance_time AND p.performance_time <= new_end)
      );

    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This building already has a performance at this time.';
    END IF;

END$$


/* This trigger prevents deleting security and helper staff when the number of them is lower than needed */

CREATE TRIGGER prevent_staff_drop
BEFORE DELETE ON staff
FOR EACH ROW
BEGIN
    DECLARE buildingCapacity INT;
    DECLARE currentCount INT;
    DECLARE requiredCount INT;

    -- Only apply constraints for security and helper categories
    IF OLD.role IN ('security', 'helper') THEN

        -- Get the building's capacity
        SELECT max_capacity INTO buildingCapacity
        FROM building
        WHERE building_id = OLD.building_id;

        -- Apply rules based on staff category
        IF OLD.role = 'security' THEN
            SET requiredCount = CEIL(buildingCapacity * 0.05);

            SELECT COUNT(*) INTO currentCount
            FROM staff
            WHERE building_id = OLD.building_id
              AND role = 'security';

            IF (currentCount - 1) < requiredCount THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Cannot delete this security staff member; doing so would drop the security coverage below 5% of building capacity.';
            END IF;

        ELSEIF OLD.role = 'helper' THEN
            SET requiredCount = CEIL(buildingCapacity * 0.02);

            SELECT COUNT(*) INTO currentCount
            FROM staff
            WHERE building_id = OLD.building_id
              AND staff_category = 'helper';

            IF (currentCount - 1) < requiredCount THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Cannot delete this helper staff member; doing so would drop the helper coverage below 2% of building capacity.';
            END IF;

        END IF;
    END IF;

END$$


/* This trigger prevents visitors from having multiple tickets for the same event */

CREATE TRIGGER prevent_duplicate_visitor_ticket
BEFORE INSERT ON visitor
FOR EACH ROW
BEGIN
    DECLARE dup_count INT;

    SELECT COUNT(*) INTO dup_count
    FROM ticket t
    JOIN visitor v ON t.visitor_id = v.visitor_id
    WHERE v.visitor_email = NEW.visitor_email
      AND t.ticket_day_of_purchase = (
          SELECT ticket_day_of_purchase
          FROM ticket
          WHERE visitor_id = NEW.visitor_id
          LIMIT 1
      )
      AND t.event_id = (
          SELECT event_id
          FROM ticket
          WHERE visitor_id = NEW.visitor_id
          LIMIT 1
      );

    IF dup_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Visitor already has a ticket for this event on this day.';
    END IF;
END$$


CREATE TRIGGER trg_visitor_after_insert
AFTER INSERT ON visitor
FOR EACH ROW
BEGIN
    DECLARE visitor_count INT;
    DECLARE event_for_ticket INT;
    DECLARE ticket_for_visitor INT;
    DECLARE maximum_tickets INT;

    -- Get the ticket and event_id for the new visitor
    SELECT ticket_id, tick.event_id, max_capacity
    INTO ticket_for_visitor, event_for_ticket, maximum_tickets
    FROM ticket tick
    INNER JOIN event ev
    ON ev.event_id = tick.event_id
    INNER JOIN building build
    ON ev.building_id = build.building_id
    WHERE visitor_id = NEW.visitor_id
    LIMIT 1;

    -- Count how many visitors are linked to this event
    SELECT COUNT(DISTINCT v.visitor_id)
    INTO visitor_count
    FROM visitor v
    JOIN ticket t ON v.visitor_id = t.visitor_id
    WHERE t.event_id = event_for_ticket;

    -- If more than or equal to the max capacity of the building, insert into reselling_queue
    IF visitor_count >= maximum_tickets THEN
        INSERT INTO reselling_queue (event_id, ticket_id, seller_id, buyer_id)
        SELECT
            t.event_id,
            t.ticket_id,
            v.visitor_id,
            NULL
        FROM ticket t
        JOIN visitor v ON v.visitor_id = t.visitor_id
        WHERE t.event_id = event_for_ticket
          AND t.ticket_is_active = FALSE
          AND v.wanting_to_sell = TRUE
          AND NOT EXISTS (
              SELECT 1
              FROM reselling_queue rq
              WHERE rq.ticket_id = t.ticket_id
          );
    END IF;
END$$




CREATE TRIGGER trg_visitor_after_update
AFTER UPDATE ON visitor
FOR EACH ROW
BEGIN
    DECLARE visitor_count INT;
    DECLARE event_for_ticket INT;
    DECLARE ticket_for_visitor INT;
    DECLARE maximum_tickets INT;

    -- Get the ticket and event_id for the new visitor
    SELECT ticket_id, tick.event_id, max_capacity
    INTO ticket_for_visitor, event_for_ticket, maximum_tickets
    FROM ticket tick
    INNER JOIN event ev
    ON ev.event_id = tick.event_id
    INNER JOIN building build
    ON ev.building_id = build.building_id
    WHERE visitor_id = NEW.visitor_id
    LIMIT 1;


    -- Count how many visitors are linked to this event
    SELECT COUNT(DISTINCT v.visitor_id)
    INTO visitor_count
    FROM visitor v
    JOIN ticket t ON v.visitor_id = t.visitor_id
    WHERE t.event_id = event_for_ticket;

    -- If more than or equal to the max capacity of the building, insert into reselling_queue
    IF visitor_count >= maximum_tickets THEN
        INSERT INTO reselling_queue (event_id, ticket_id, seller_id, buyer_id)
        SELECT
            t.event_id,
            t.ticket_id,
            v.visitor_id,
            NULL
        FROM ticket t
        JOIN visitor v ON v.visitor_id = t.visitor_id
        WHERE t.event_id = event_for_ticket
          AND t.ticket_is_active = FALSE
          AND v.wanting_to_sell = TRUE
          AND NOT EXISTS (
              SELECT 1
              FROM reselling_queue rq
              WHERE rq.ticket_id = t.ticket_id
          );
    END IF;
END$$


CREATE TRIGGER trg_after_buyer_insert
AFTER INSERT ON buyers
FOR EACH ROW
BEGIN
  DECLARE v_qid        INT;
  DECLARE v_seller_id  INT;
  DECLARE v_ticket_id  INT;

  -- 1) Grab the oldest queued seller + ticket for this event
  SELECT reselling_queue_id, seller_id, ticket_id
    INTO v_qid, v_seller_id, v_ticket_id
    FROM reselling_queue
   WHERE event_id  = NEW.event_id
     AND seller_id IS NOT NULL
   ORDER BY reselling_queue_id 
   LIMIT 1;

  -- If no seller was waiting, just enqueue this buyer for later
  IF v_seller_id IS NULL THEN
    INSERT INTO reselling_queue (event_id, buyer_id)
    VALUES (NEW.event_id, NEW.buyer_id);

  ELSE
    -- 2) Overwrite that seller’s visitor record with the buyer’s details
    UPDATE visitor
       SET visitor_name         = NEW.buyer_name,
           visitor_surname      = NEW.buyer_surname,
           visitor_phone_number = NEW.buyer_phone_number,
           visitor_email        = NEW.buyer_email,
           visitor_age          = NEW.buyer_age,
           wanting_to_sell      = FALSE
     WHERE visitor_id = v_seller_id;

    -- 3) Reassign the ticket to that same visitor_id
    UPDATE ticket
       SET visitor_id = v_seller_id
     WHERE ticket_id = v_ticket_id;

    -- 4) Pop that seller off the queue
    DELETE FROM reselling_queue
     WHERE reselling_queue_id = v_qid;
  END IF;

END$$


DELIMITER ;
