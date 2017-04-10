USE scheduling;

# Add's a student to the student table with the given parameters
DELIMITER $$
CREATE PROCEDURE add_student
(
	fn	VARCHAR(50),
    ln	VARCHAR(50),
    gy	INT(11),
    maj	VARCHAR(50)
)
BEGIN
	INSERT INTO student (fname, lname, grad, major)
	VALUES(fn, ln, gy, maj);
END $$

# Add's a course to the "course" table with the given parameters
DELIMITER $$
CREATE PROCEDURE add_course
(
	sub		VARCHAR(10),
    num		INT(11),
    name	VARCHAR(50),
    str		TIME,
    end		TIME,
    day		SET('M','T','W','R','F'),
    crn		INT(11),
    cap		INT(11),
    credits INT(11)
)
BEGIN
	INSERT INTO course (course_subject, course_num, course_name, stime, ftime, days, crn, capacity, credits)
    VALUES(sub, num, name, str, end, day, crn, cap, credits);
END $$

# Returns the schedule of the student with the given student ID.
DELIMITER $$
CREATE PROCEDURE get_schedule
(
	id	INT(11)
)
BEGIN
	SELECT crn, course_subject, course_num, course_name, stime, ftime, days, capacity, credits
    FROM student_reg, course
    WHERE student_id = id
		AND reg_crn = crn;
END $$

# Adds a class to a students schedule
DELIMITER $$
CREATE PROCEDURE add_class
(
	id	INT(11),
    crn INT(11)
)
BEGIN
	DECLARE seq_num INT;
    SET seq_num = (SELECT MAX(reg_crn) FROM student_reg WHERE student_id = id);
    
    IF seq_num IS NULL THEN
		INSERT INTO student_reg
        VALUES(id, 1, crn);
	ELSE
		INSERT INTO student_reg
        VALUES(id, seq_num + 1, crn);
	END IF;
END $$

# Removes a class from a students schedule
DELIMITER $$
CREATE PROCEDURE drop_class
(
	id	INT(11),
    crn INT(11)
)
BEGIN
	DELETE
    FROM student_reg
    WHERE student_id = id
		AND reg_crn = crn;
END $$

# Assigns a professor to an existing course
DELIMITER $$
CREATE PROCEDURE assign_prof
(
	pid INT(11),
    crn INT(11)
)
BEGIN
	UPDATE course
    SET prof_id = pid
    WHERE crn = crn;
END    
    