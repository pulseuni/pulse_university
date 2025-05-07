CREATE DATABASE alternative_project;
USE alternative_project;

CREATE TABLE festival (
	festival_id int(5) AUTO_INCREMENT NOT NULL,
	location_name varchar(50) NOT NULL,
	day varchar(15) NOT NULL, 
	year int(4) NOT NULL,	
	PRIMARY KEY(festival_id)
	);

CREATE TABLE event (
	event_id int(5) AUTO_INCREMENT NOT NULL,
	event_name varchar(50) NOT NULL,
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
	artist_type varchar(50) NOT NULL,
	artist_subtype varchar(50) ,
	social_media varchar(50),
	PRIMARY KEY(artist_id)
	);

CREATE TABLE band (
    band_id int(5) AUTO_INCREMENT NOT NULL,
    band_name varchar(50) NOT NULL,
    number_of_artists int(5) NOT NULL,
    artists varchar(255) NOT NULL,  -- Storing the list as a comma-separated string
    type_of_music varchar(50) NOT NULL,
    subtype_of_music varchar(50),
    date_of_creation varchar(10) NOT NULL,
    website varchar(50),
    PRIMARY KEY(band_id),
    -- Constraint for ensuring the number of artists is between 2 and 8
    CHECK (LENGTH(artists) - LENGTH(REPLACE(artists, ',', '')) + 1 BETWEEN 2 AND 8),
    -- Constraint for ensuring that the number of artists matches the length of the list
    CHECK (number_of_artists = LENGTH(artists) - LENGTH(REPLACE(artists, ',', '')) + 1)
);
	
CREATE TABLE performance_artist (
	performance_id int(5) NOT NULL,
	artist_id int(5) NOT NULL,
	PRIMARY KEY(performance_id,artist_id),
	CONSTRAINT fk_performance_artist_1 FOREIGN KEY(performance_id) REFERENCES performance(performance_id),
	CONSTRAINT fk_performance_artist_2 FOREIGN KEY(artist_id) REFERENCES artist(artist_id)
	);

ALTER TABLE performance
ADD band_id int(5) NOT NULL;
ALTER TABLE performance 
ADD CONSTRAINT fk_performance_1 FOREIGN KEY(band_id) REFERENCES band(band_id);

ALTER TABLE performance
ADD event_id int(5) NOT NULL;
ALTER TABLE performance 
ADD CONSTRAINT fk_performance_2 FOREIGN KEY(event_id) REFERENCES event(event_id);

ALTER TABLE artist
ADD band_id int(5) NOT NULL;
ALTER TABLE artist 
ADD CONSTRAINT fk_artist_1 FOREIGN KEY(band_id) REFERENCES band(band_id);

CREATE TABLE location (
	location_id int(5) AUTO_INCREMENT NOT NULL,
	address varchar(50) NOT NULL,
	cords varchar(50) NOT NULL,
	city varchar(50) NOT NULL,
	country varchar(50) NOT NULL,
	continent varchar(50) NOT NULL,
	PRIMARY KEY(location_id)
	);

ALTER TABLE festival
ADD location_id int(5) NOT NULL;
ALTER TABLE festival
ADD CONSTRAINT fk_festival_1 FOREIGN KEY(location_id) REFERENCES location(location_id);






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
	ticket_id int(5) NOT NULL,
	CONSTRAINT fk_visitor_1 FOREIGN KEY(ticket_id) REFERENCES ticket(ticket_id),
	PRIMARY KEY(visitor_id)
	);

CREATE TABLE reselling_queue (
    queue_id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT NOT NULL,
    event_id INT NOT NULL,
    seller_id INT,
    buyer_id INT,
    queue_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_rq1 FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id),
    CONSTRAINT fk_rq2 FOREIGN KEY (event_id) REFERENCES event(event_id),
    CONSTRAINT fk_rq3 FOREIGN KEY (seller_id) REFERENCES visitor(visitor_id),
    CONSTRAINT fk_rq4 FOREIGN KEY (buyer_id) REFERENCES visitor(visitor_id)
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

CREATE TABLE event_rating (
	event_id int(5) NOT NULL,
	rating_id int(5) NOT NULL,
	PRIMARY KEY(event_id, rating_id),
	CONSTRAINT fk_event_rating_1 FOREIGN KEY(event_id) REFERENCES event(event_id),
	CONSTRAINT fk_event_rating_2 FOREIGN KEY(rating_id) REFERENCES rating(rating_id)
	);

ALTER TABLE event
ADD festival_id int(5) NOT NULL;

ALTER TABLE event
ADD CONSTRAINT fk_event_1 FOREIGN KEY(festival_id) REFERENCES festival(festival_id);

ALTER TABLE event
ADD building_id int(5) NOT NULL;

ALTER TABLE event
ADD CONSTRAINT fk_event_2 FOREIGN KEY(building_id) REFERENCES building(building_id);

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



ALTER TABLE festival
ADD CONSTRAINT unique_location_per_year UNIQUE(	location_id,year);


ALTER TABLE performance
ADD CONSTRAINT chk_break CHECK (break BETWEEN 5 AND 30);

ALTER TABLE performance
ADD CONSTRAINT chk_duration CHECK (duration BETWEEN 0 AND 3);










DELIMITER $$

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



CREATE TRIGGER prevent_band_consecutive_years
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
	DECLARE band_year INT;
	DECLARE y1 INT; DECLARE y2 INT; DECLARE y3 INT; DECLARE y4 INT;

	SELECT f.year INTO band_year
	FROM event e
	JOIN festival f ON e.festival_id = f.festival_id
	WHERE e.event_id = NEW.event_id;

	SELECT 
		MAX(CASE WHEN f.year = band_year - 1 THEN 1 ELSE 0 END) AS y1,
		MAX(CASE WHEN f.year = band_year - 2 THEN 1 ELSE 0 END) AS y2,
		MAX(CASE WHEN f.year = band_year - 3 THEN 1 ELSE 0 END) AS y3,
		MAX(CASE WHEN f.year = band_year - 4 THEN 1 ELSE 0 END) AS y4
	INTO y1, y2, y3, y4
	FROM performance p
	JOIN event e ON p.event_id = e.event_id
	JOIN festival f ON e.festival_id = f.festival_id
	WHERE p.band_id = NEW.band_id;

	IF y1 = 1 AND y2 = 1 AND y3 = 1 THEN
    		SIGNAL SQLSTATE '45000'
    		SET MESSAGE_TEXT = 'Band cannot perform for more than 3 consecutive years.';
	END IF;

END$$


CREATE TRIGGER prevent_artist_double_booking
BEFORE INSERT ON performance_artist
FOR EACH ROW
BEGIN
	DECLARE new_start INT;
	DECLARE new_duration INT;
	DECLARE new_end INT;
	DECLARE overlap_count INT;

	SELECT performance_time, duration 
	INTO new_start, new_duration
	FROM performance 
	WHERE performance_id = NEW.performance_id;

	SET new_end = new_start + new_duration;

	SELECT COUNT(*) INTO overlap_count
	FROM performance_artist pa
	JOIN performance p ON pa.performance_id = p.performance_id
	WHERE pa.artist_id = NEW.artist_id
     		AND ((new_start < (p.performance_time + p.duration)) 
        	AND (new_end > p.performance_time));

	IF overlap_count > 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'This artist is already booked for another performance at overlapping times.';
	END IF;

END$$


CREATE TRIGGER prevent_artist_consecutive_years
BEFORE INSERT ON performance_artist
FOR EACH ROW
BEGIN
	DECLARE new_year INT;
	DECLARE count_consecutive INT;

	SELECT f.year INTO new_year
	FROM performance p
	JOIN event e ON p.event_id = e.event_id
	JOIN festival f ON e.festival_id = f.festival_id
	WHERE p.performance_id = NEW.performance_id;

	SELECT COUNT(DISTINCT f.year) INTO count_consecutive FROM performance_artist pa
	JOIN performance p ON pa.performance_id = p.performance_id
	JOIN event e ON p.event_id = e.event_id
	JOIN festival f ON e.festival_id = f.festival_id
	WHERE pa.artist_id = NEW.artist_id
		AND f.year BETWEEN new_year - 3 AND new_year - 1;

	IF count_consecutive = 3 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'This artist cannot participate in more than 3 consecutive years.';
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



/* CREATE TRIGGER prevent_used_ticket_resell
BEFORE INSERT ON reselling_queue
FOR EACH ROW
BEGIN
    DECLARE is_active BOOLEAN;
    SELECT ticket_is_active INTO is_active FROM ticket WHERE ticket_id = NEW.ticket_id;
    
    IF is_active THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Only inactive tickets can be resold.';
    END IF;

END$$ */



/* This is for checking that no festivals happen on the same location for two consecutive years */


CREATE TRIGGER check_consecutive_year_location_insert
BEFORE INSERT ON Festival
FOR EACH ROW
BEGIN
    DECLARE conflict_count INT;

    SELECT COUNT(*) INTO conflict_count
    FROM festival
    WHERE location_name = NEW.location_name
      AND (year = NEW.year - 1 OR year = NEW.year + 1);

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Festival locations must skip at least one year before being reused.';
    END IF;
END$$


/* This is for checking that no festivals happen on the same location for two consecutive years */

CREATE TRIGGER check_consecutive_year_location_update
BEFORE UPDATE ON Festival
FOR EACH ROW
BEGIN
    DECLARE conflict_count INT;

    SELECT COUNT(*) INTO conflict_count
    FROM festival
    WHERE location_name = NEW.location_name
      AND ((year = NEW.year - 1 OR year = NEW.year + 1) AND (festival_id <> NEW.festival_id));

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


CREATE TRIGGER prevent_duplicate_visitor_ticket
BEFORE INSERT ON visitor
FOR EACH ROW
BEGIN
    DECLARE dup_count INT;

    SELECT COUNT(*) INTO dup_count
    FROM visitor v
    JOIN ticket t ON v.ticket_id = t.ticket_id
    WHERE v.visitor_email = NEW.visitor_email
      AND t.ticket_day_of_purchase = (SELECT ticket_day_of_purchase FROM ticket WHERE ticket_id = NEW.ticket_id)
      AND t.event_id = (SELECT event_id FROM ticket WHERE ticket_id = NEW.ticket_id);

    IF dup_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Visitor already has a ticket for this event on this day.';
    END IF;
END$$

DELIMITER ;


-- Corrected trigger: Redirect excess tickets to reselling_queue
DELIMITER $$

CREATE TRIGGER trg_ticket_after_insert
AFTER INSERT ON ticket
FOR EACH ROW
BEGIN
    DECLARE current_count INT;

    -- Count how many tickets are sold for this event
    SELECT COUNT(*) INTO current_count
    FROM ticket
    WHERE event_id = NEW.event_id;

    -- If more than 190, move this ticket to reselling_queue and delete from ticket
    IF current_count > 190 THEN
        INSERT INTO reselling_queue (event_id, ticket_id, seller_id, buyer_id)
        VALUES (NEW.event_id, NEW.ticket_id, NULL, NULL);

        
    END IF;
END$$

DELIMITER ;

