-- Student values
INSERT INTO student (fname, lname, grad, major)
VALUES ('Anirudh', 'Kaushik', 2019, 'Computer Science and Biology');

INSERT INTO student (fname, lname, grad, major)
VALUES ('Ethan', 'March', 2019, 'Data Science');

INSERT INTO student (fname, lname, grad, major)
VALUES ('Gabriel', 'Centeno', 2019, 'Computer Science and Finance');

INSERT INTO student (fname, lname, grad, major)
VALUES ('Trent', 'Duffy', 2019, 'Computer Science');

INSERT INTO student (fname, lname, grad, major)
VALUES ('Paul', 'Langton', 2019, 'Computer Science');

INSERT INTO student (fname, lname, grad, major)
VALUES ('Nicholas', 'Chiappari', 2019, 'Computer Science');

INSERT INTO student (fname, lname, grad, major)
VALUES ('Josh', 'Hoffman', 2020, 'Computer Science and Math');

INSERT INTO student (fname, lname, grad, major)
VALUES ('Wesley', 'Baranowski', 2020, 'Math');

INSERT INTO student (fname, lname, grad, major)
VALUES ('Will', 'Gooley', 2020, 'Computer Science and Math');

INSERT INTO student (fname, lname, grad, major)
VALUES ('Amal', 'Nazeem', 2020, 'Computer Science');

INSERT INTO student (fname, lname, grad, major)
VALUES ('Alex', 'Aubuchon', 2019, 'Computer Science');

INSERT INTO student (fname, lname, grad, major)
VALUES ('Raghavprassana', 'Rajagopalan', 2019, 'Computer Science and Biology');


-- Professor Values
INSERT INTO professor (fname, lname)
VALUES ('Nathaniel', 'Tuck');

INSERT INTO professor (fname, lname)
VALUES ('Leena', 'Razzaq');

INSERT INTO professor (fname, lname)
VALUES ('Benjamin', 'Lerner');

INSERT INTO professor (fname, lname)
VALUES ('Kathleen', 'Durant');

INSERT INTO professor (fname, lname)
VALUES ('Matthias', 'Felleisen');

INSERT INTO professor (fname, lname)
VALUES ('Amit', 'Shesh');

INSERT INTO professor (fname, lname)
VALUES ('Abhi', 'Shalat');

INSERT INTO professor (fname, lname)
VALUES ('Martin', 'Schedlbauer');

INSERT INTO professor (fname, lname)
VALUES ('Nada', 'Naji');

INSERT INTO professor (fname, lname)
VALUES ('David', 'Sprague');

INSERT INTO professor (fname, lname)
VALUES ('Jacek', 'Ossowski');


-- Classroom Values
INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('23H', 119, 56);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('23H', 120, 56);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('23H', 124, 50);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('80', 110, 60);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('53', 404, 30);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('53', 405, 30);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('42', 215, 200);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('42', 415, 200);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('30', 325, 60);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('30', 315, 60);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('30', 305, 60);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('24', 415, 30);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('24', 425, 30);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('46', 120, 60);

INSERT INTO classroom (building_code, room_num, capacity)
VALUES ('46', 125, 60);


-- Course Values
INSERT INTO course VALUES ('CS', 2500, 'Fundementals of Computer Science', 9:15:00, 10:20:00, 'MWTh', 34567, 56, 1, 1, 4);

INSERT INTO course VALUES ('CS', 2500, 'Fundementals of Computer Science', 9:15:00, 10:20:00, 'MWTh', 41570, 60, 2, 4, 4);

INSERT INTO course VALUES ('CS', 1800, 'Discrete Structures', 10:30:00, 11:35:00, 'MWTh', 52346, 60, 5, 9, 4);

INSERT INTO course VALUES ('CS', 1800, 'Discrete Structures', 10:30:00, 11:35:00, 'MWTh', 12534, 60, 7, 10, 4);

INSERT INTO course VALUES ('CS', 2510, 'Fundementals of Computer Science II', 9:15:00, 10:20:00, 'MWTh', 35672, 60, 3, 11, 4);

INSERT INTO course VALUES ('CS', 2510, 'Fundementals of Computer Science II', 9:15:00, 10:20:00, 'MWTh', 89576, 60, 9, 14, 4);

INSERT INTO course VALUES ('CS', 2800, 'Logic and Computation', 10:30:00, 11:35:00, 'MWTh', 65738, 30, 10, 5, 4);

INSERT INTO course VALUES ('CS', 2800, 'Logic and Computation', 10:30:00, 11:35:00, 'MWTh', 43167, 30, 11, 6, 4);

-- Prereq Values



-- Student Reg values
INSERT INTO student_reg VALUES (1, 1,34567);

INSERT INTO student_reg VALUES (1, 2,52346);

INSERT INTO student_reg VALUES (2, 1,34567);

INSERT INTO student_reg VALUES (2, 2,52346);

INSERT INTO student_reg VALUES (3, 1,41570);

INSERT INTO student_reg VALUES (3, 2,12534);

INSERT INTO student_reg VALUES (4, 1,41570);

INSERT INTO student_reg VALUES (4, 2,12534);

INSERT INTO student_reg VALUES (5, 1,35672);

INSERT INTO student_reg VALUES (5, 2,65738);

INSERT INTO student_reg VALUES (6, 1,35672);

INSERT INTO student_reg VALUES (6, 2,65738);

INSERT INTO student_reg VALUES (7, 1,89576);

INSERT INTO student_reg VALUES (7, 2,43167);

INSERT INTO student_reg VALUES (8, 1,89576);

INSERT INTO student_reg VALUES (8, 2,43167);

INSERT INTO student_reg VALUES (9, 1,41570);

INSERT INTO student_reg VALUES (9, 2,52346);

INSERT INTO student_reg VALUES (10, 1,41570);

INSERT INTO student_reg VALUES (10, 2,52346);

INSERT INTO student_reg VALUES (11, 1,89576);

INSERT INTO student_reg VALUES (11, 2,65738);

INSERT INTO student_reg VALUES (12, 1,34567);

INSERT INTO student_reg VALUES (12, 2,12534);


-- Student History Values

INSERT INTO student_history VALUES (12, ,12534);










