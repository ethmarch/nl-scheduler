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
			SELECT IF(COUNT(teaching_seq) = 0, 0, MAX(teaching_seq))
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
			SELECT IF(COUNT(teaching_seq) = 0, 0, MAX(teaching_seq))
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
			SELECT *
			FROM prereq a1
				LEFT JOIN student_history a2
					ON a1.prereq_subj = a2.taken_subj
						AND a1.prereq_num = a2.taken_num
			WHERE a2.student_id IS NULL
        ) AS a3;
        
        IF not_satisfied > 0
        THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot add or update row: Prerequisite courses not satsified';
		END IF;
	END//

DELIMITER ;

# Checks if student has time conflict with registered course
DROP TRIGGER IF EXISTS check_student_time_conflict;

DELIMITER //

CREATE TRIGGER check_student_time_conflict
	BEFORE INSERT ON student_reg
    FOR EACH ROW
    BEGIN
		DECLARE	stime			INT;
        DECLARE ftime			INT;
        DECLARE days			SET('M','T','W','R','F');
        DECLARE	conflict_count	INT;
        
		# course to be added
		SELECT stime, ftime, CONV(CAST(days AS SIGNED),10,2)
        INTO stime, ftime, days
        FROM course
        WHERE crn = NEW.reg_crn;
        
        # current student's schedule
		SELECT COUNT(*)
        INTO conflict_count
        FROM student_reg a1
			INNER JOIN course a2
            ON a1.reg_crn = a2.crn
        WHERE a1.student_id = NEW.student_id
			AND (@days & a2.days) > 0
            AND ((@stime > a2.stime)
				OR (@ftime < a2.ftime));
        
        # check for conflicts
        IF conflict_count > 0
        THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot add or update row: Prerequisite courses not satsified';
		END IF;
    END//

DELIMITER ;

# Checks if professor has time conflict with registered course
DROP TRIGGER IF EXISTS check_prof_time_conflict;

DELIMITER //

CREATE TRIGGER check_prof_time_conflict
	BEFORE INSERT ON prof_reg
    FOR EACH ROW
    BEGIN
		DECLARE	stime			INT;
        DECLARE ftime			INT;
        DECLARE days			SET('M','T','W','R','F');
        DECLARE	conflict_count	INT;
        
		# course to be added
		SELECT stime, ftime, CONV(CAST(days AS SIGNED),10,2)
        INTO stime, ftime, days
        FROM course
        WHERE crn = NEW.reg_crn;
        
        # current student's schedule
		SELECT COUNT(*)
        INTO conflict_count
        FROM prof_reg a1
			INNER JOIN course a2
            ON a1.reg_crn = a2.crn
        WHERE a1.prof_id = NEW.prof_id
			AND (@days & a2.days) > 0
            AND ((@stime > a2.stime)
				OR (@ftime < a2.ftime));
        
        # check for conflicts
        IF conflict_count > 0
        THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot add or update row: Prerequisite courses not satsified';
		END IF;
    END//

DELIMITER ;

# Checks if course has time conflict with existing course
DROP TRIGGER IF EXISTS check_course_time_conflict;

DELIMITER //

CREATE TRIGGER check_course_time_conflict
	BEFORE INSERT ON course
    FOR EACH ROW
    BEGIN
        DECLARE	conflict_count	INT;
        
		SELECT COUNT(*)
        INTO conflict_count
        FROM course
        WHERE crn = NEW.crn
			AND ((CONV(CAST(NEW.days AS SIGNED),10,2)) & days) > 0
            AND ((NEW.stime > stime)
				OR (NEW.ftime < ftime));
        
        # check for conflicts
        IF conflict_count > 0
        THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot add or update row: Prerequisite courses not satsified';
		END IF;
    END//

DELIMITER ;