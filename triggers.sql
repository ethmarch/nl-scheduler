USE scheduling;

# Ensures a given professor can teach a class before assigned to a course
DROP TRIGGER IF EXISTS prof_can_teach_before_added_to_course;

DELIMITER //

CREATE TRIGGER prof_can_teach_before_added_to_course
	BEFORE INSERT ON course
    FOR EACH ROW
    BEGIN
		DECLARE	prof_teaches_class	INT;
        
        SELECT COUNT(*)
        INTO prof_teaches_class
        FROM prof_subject
        WHERE prof_id = NEW.prof_id
			AND course_subject = NEW.course_subject
            AND course_number = NEW.course_num;
		
        IF prof_teaches_class = 0
        THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot add or update row: Professor does not teach class';
		END IF;
	END //

DELIMITER ;

# Adds a registration to prof_reg after course added with prof
DROP TRIGGER IF EXISTS prof_in_reg_after_added_to_course;

DELIMITER //

CREATE TRIGGER prof_in_reg_after_added_to_course
	AFTER INSERT ON course
    FOR EACH ROW
    BEGIN
		DECLARE max_seq	INT;
        
        IF (NEW.prof_id IS NOT NULL)
        THEN
			SELECT MAX(teaching_seq)
			INTO max_seq
			FROM prof_reg
			WHERE prof_id = NEW.prof_id;
			
			INSERT INTO prof_reg
			VALUES (NEW.prof_id, max_seq + 1, NEW.crn);
        END IF;
	END//

DELIMITER ;

# Adds a registration to prof_reg after course updated with prof
DROP TRIGGER IF EXISTS prof_in_reg_after_added_to_course;

DELIMITER //

CREATE TRIGGER prof_in_reg_after_added_to_course
	AFTER UPDATE ON course
    FOR EACH ROW
    BEGIN
		DECLARE max_seq	INT;
		
		IF NOT (NEW.prof_id <=> OLD.prof_id)
        THEN
			SELECT MAX(teaching_seq)
			INTO max_seq
			FROM prof_reg
			WHERE prof_id = NEW.prof_id;
			
			INSERT INTO prof_reg
			VALUES (NEW.prof_id, max_seq + 1, NEW.crn);
		END IF;
	END//

DELIMITER ;

# Adds professor to course after added to prof_reg (reverse of trigger above)
DROP TRIGGER IF EXISTS prof_in_course_after_registered;

DELIMITER //

CREATE TRIGGER prof_in_course_after_registered
	AFTER INSERT ON prof_reg
    FOR EACH ROW
    BEGIN
		UPDATE course
        SET prof_id = NEW.prof_id
        WHERE crn = NEW.reg_crn;
    END//

DELIMITER ;

# Checks that a course capacity does not exceed its room's capacity
DROP TRIGGER IF EXISTS course_capacity_less_than_room_capacity;

DELIMITER //

CREATE TRIGGER course_capacity_less_than_room_capacity
	BEFORE INSERT ON course
    FOR EACH ROW
    BEGIN
		DECLARE	room_cap	INT;
        
        SELECT capacity
        INTO room_cap
        FROM classroom
        WHERE room_idx = NEW.room_idx;
        
        IF room_cap < NEW.capacity
        THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot add or update row: Course capacity exceeds room capacity';
		END IF;
	END//

DELIMITER ;

# Checks that a course registration does not exceed its capacity
DROP TRIGGER IF EXISTS course_reg_less_than_capacity;

DELIMITER //

CREATE TRIGGER course_reg_less_than_capacity
	BEFORE INSERT ON student_reg
    FOR EACH ROW
    BEGIN
		DECLARE	course_reg	INT;
        DECLARE	course_cap	INT;
        
        # Students cannot register for the same course twice, so this will always
        # produce the number of unique students that registered for the course
        SELECT COUNT(*)
        INTO course_reg
        FROM student_reg
        WHERE reg_crn = NEW.reg_crn;
        
        SELECT capacity
        INTO course_cap
        FROM course
        WHERE crn = NEW.reg_crn;
        
        IF course_reg > course_cap
        THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot add or update row: Course full';
		END IF;
	END//

DELIMITER ;

# Ensures student cannot register for same course twice
DROP TRIGGER IF EXISTS student_already_registered_not_registered_again;

DELIMITER //

CREATE TRIGGER student_already_registered_not_registered_again
	BEFORE INSERT ON student_reg
    FOR EACH ROW
    BEGIN
		DECLARE	student_registered	BOOLEAN;
        
        SELECT IF(COUNT(*) = 0, 0, 1)
        INTO student_registered
        FROM student_reg
        WHERE student_id = NEW.student_id
			AND reg_crn = NEW.reg_crn;
        
        IF student_registered
        THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot add or update row: Student already registered for course';
		END IF;
	END//

DELIMITER ;

# Checks if student has prerequisites for class before registered for course
DROP TRIGGER IF EXISTS check_prerequisites;

DELIMITER //

CREATE TRIGGER check_prerequisites
	BEFORE INSERT ON student_reg
    FOR EACH ROW
    BEGIN
		DECLARE	not_satisfied	INT;
        
		SELECT COUNT(*)
        INTO not_satisfied
        FROM
        (
			SELECT a1.prereq_subj, a1.prereq_num
            FROM prereq AS a1
            WHERE
            (
				SELECT 1
                FROM student_history AS a2
                WHERE a2.taken_subj = a1.prereq_subj
					AND a2.taken_num = a1.prereq_num
            )
        ) AS a3;
        
        IF not_satisfied > 0
        THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot add or update row: Prerequisite courses not satsified';
		END IF;
	END//

DELIMITER //