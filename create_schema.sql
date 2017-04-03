DROP SCHEMA IF EXISTS scheduling;
CREATE SCHEMA scheduling;
USE scheduling;




CREATE TABLE student
(
	student_id			INT 			PRIMARY KEY		AUTO_INCREMENT,
    fname				VARCHAR(50)		NOT NULL,
    lname				VARCHAR(50)		NOT NULL,
    grad				INT				NOT NULL,
    major				VARCHAR(50)		NOT NULL
);


CREATE TABLE professor
(
	prof_id				INT    			PRIMARY KEY		AUTO_INCREMENT,
    fname				VARCHAR(50)		NOT NULL,
	lname				VARCHAR(50)		NOT NULL
);

CREATE TABLE classroom
(
	room_idx			INT				PRIMARY KEY 	AUTO_INCREMENT,
    building_code		VARCHAR(3)		NOT NULL,
    room_num			INT 			NOT NULL,
    capacity			INT 			NOT NULL
);


CREATE TABLE course
(
	course_subject		VARCHAR(10)		NOT NULL,
    course_num			INT				NOT NULL,
    course_name			VARCHAR(50)		NOT NULL,
    stime				TIME 			NOT NULL,
    ftime				TIME 			NOT NULL,
    days				VARCHAR(5)		NOT NULL,
    crn					INT				PRIMARY KEY,
    capacity			INT				NOT NULL,
    prof_id				INT 			NOT NULL,
    room_idx			INT				NOT NULL,
    credits				INT 			NOT NULL,
    CONSTRAINT course_fk1
		FOREIGN KEY (prof_id)
        REFERENCES professor (prof_id),
	CONSTRAINT course_fk2
		FOREIGN KEY (room_idx)
        REFERENCES classroom (room_idx)
);

CREATE TABLE prereq
(
	parent_subj			VARCHAR(8)			NOT NULL,
    parent_num			INT					NOT NULL,
    prereq_seq			INT					NOT NULL,
    prereq_subj			VARCHAR(8)			NOT NULL,
    prereq_num			INT					NOT NULL,
    CONSTRAINT prereq_pk
		PRIMARY KEY(parent_subj, parent_num, prereq_seq)
);

CREATE TABLE student_reg
(
	student_id			INT, 			
    learning_seq		INT, 			
    reg_crn				INT				NOT NULL,
    CONSTRAINT student_reg_pk
		PRIMARY KEY (student_id, learning_seq),
    CONSTRAINT student_reg_fk1
		FOREIGN KEY (student_id)
        REFERENCES student (student_id),
	CONSTRAINT student_reg_fk2
		FOREIGN KEY (reg_crn)
        REFERENCES course (crn)
);

CREATE TABLE student_history
(
	student_id			INT,
    taken_seq			INT,
    taken_crn			INT				NOT NULL,
    taken_subj			VARCHAR(8)		NOT NULL,
    taken_num			INT 			NOT NULL,
    CONSTRAINT student_history_pk
		PRIMARY KEY (student_id, taken_seq),
    CONSTRAINT student_history_fk1
		FOREIGN KEY (student_id)
        REFERENCES student (student_id),
	CONSTRAINT student_history_fk2
		FOREIGN KEY (taken_crn)
        REFERENCES course (crn)
);

CREATE TABLE prof_subject
(
	prof_id				INT,
    subject_seq			INT,
    course_subject		VARCHAR(50)		NOT NULL,
    course_number		INT 			NOT NULL,
    CONSTRAINT prof_subject_pk
		PRIMARY KEY (prof_id, subject_seq),
    CONSTRAINT prof_subject_fk1
		FOREIGN KEY (prof_id)
        REFERENCES professor (prof_id)
);

CREATE TABLE prof_reg
(
	prof_id 			INT,
    teaching_seq		INT,
    reg_crn				INT 			NOT NULL,
    CONSTRAINT prof_reg_pk
		PRIMARY KEY (prof_id, teaching_seq),
    CONSTRAINT prof_reg_fk1
		FOREIGN KEY (prof_id)
        REFERENCES professor (prof_id),
	CONSTRAINT prof_reg_fk2
		FOREIGN KEY (reg_crn)
        REFERENCES course (crn)
);