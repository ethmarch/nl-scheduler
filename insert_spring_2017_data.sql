USE scheduling;

INSERT INTO
classroom
(building_code, room_num, capacity)
VALUES
('WVH',	212,	50),
('WVH',	210,	50),
('RY',	153,	30),
('SH',	215,	40),
('INV',	22,	40),
('23H',	110,	40),
('SH',	210,	40),
('RB',	107,	65),
('WVG',	104,	65),
('WVG',	102,	65),
('CG',	97,	72),
('SH',	420,	72),
('KN',	10,	75),
('RB',	109,	75),
('BK',	310,	90),
('SH',	305,	90),
('INV',	19,	80),
('HT',	130,	80),
('RI',	300,	80);

INSERT INTO
prereq
VALUES
('CS',	2510,	1,	'CS',	2500),
('CS',	2800,	1,	'CS',	1800);

INSERT INTO
professor
(fname, lname)
VALUES
('Jacek',	'Ossowski'),
('Karl',	'Lieberherr'),
('Ghita',	'Amor-Tijani'),
('Nada',	'Naji'),
('Jonathan',	'Grenier'),
('Kaitlyn',	'Hughes'),
('Melissa',	'Peikin'),
('Yasmil',	'Montes'),
('Jennifer',	'Shire'),
('Kevin',	'Gold'),
('Walter',	'Schnyder'),
('Olin',	'Shivers'),
('Nathaniel',	'Tuck'),
('Leena',	'Razzaq'),
('Benjamin',	'Lerner'),
('Clark',	'Freifeld'),
('Nada',	'Naji'),
('Thomas',	'Wahl'),
('David',	'Sprague'),
('Pete',	'Manolios');

INSERT INTO
prof_subject
VALUES
(1, 1, 'CS', 1100),
(2, 1, 'CS', 1100),

(12, 1, 'CS', 2500),
(13, 1, 'CS', 2500),

(10, 1, 'CS', 1800),
(11, 1, 'CS', 1800),

(14, 1, 'CS', 2510),
(15, 1, 'CS', 2510),

(18, 1, 'CS', 2800),
(19, 1, 'CS', 2800),
(20, 1, 'CS', 2800);

INSERT INTO
student
(fname, lname, grad, major)
VALUES
('Anirudh', 'Kaushik', 2019, 'Computer Science and Math'),
('Ethan', 'March', 2019, 'Data Science'),
('Gabriel', 'Centeno', 2019, 'Computer Science and Finance'),
('Trent', 'Duffy', 2019, 'Computer Science'),
('Paul', 'Langton', 2019, 'Computer Science'),
('Nicholas', 'Chiappari', 2019, 'Computer Science'),
('Josh', 'Hoffman', 2020, 'Computer Science and Math'),
('Wesley', 'Baranowski', 2020, 'Math'),
('Will', 'Gooley', 2020, 'Computer Science and Math'),
('Amal', 'Nazeem', 2020, 'Computer Science'),
('Alex', 'Aubuchon', 2019, 'Computer Science'),
('Raghavprassana', 'Rajagopalan', 2019, 'Computer Science and Biology');

INSERT INTO
course
VALUES
('CS', 1100, 'Computer Science and Its Applications', '8:00:00', '9:05:00', ('M'), 31617, 19, 1, 1, 4),
('CS', 1100, 'Computer Science and Its Applications', '9:15:00', '10:20:00', ('M'), 31618, 19, 2, 2, 4),

('CS', 2500, 'Fundementals of Computer Science 1', '9:15:00', '10:20:00', ('M,W,R'), 30414, 72, 12, 11, 4),
('CS', 2500, 'Fundementals of Computer Science 1', '10:30:00', '11:35:00', ('M,W,R'), 33633, 72, 12, 11, 4),
('CS', 2500, 'Fundementals of Computer Science 1', '13:35:00', '14:40:00', ('M,W,R'), 35013, 72, 13, 11, 4),
('CS', 2500, 'Fundementals of Computer Science 1', '16:35:00', '17:40:00', ('M,W,R'), 37433, 72, 13, 12, 4),


('CS', 1800, 'Discrete Structures', '9:15:00', '10:20:00', ('M,W,R'), 30567, 65, 10, 8, 4),
('CS', 1800, 'Discrete Structures', '10:30:00', '11:35:00', ('M,W,R'), 34670, 65, 11, 9, 4),
('CS', 1800, 'Discrete Structures', '10:30:00', '11:35:00', ('M,W,R'), 35012, 65, 11, 10, 4),

('CS', 2510, 'Fundementals of Computer Science 2', '9:15:00', '10:20:00', ('M,W,R'), 30361, 75, 14, 13, 4),
('CS', 2510, 'Fundementals of Computer Science 2', '9:15:00', '10:20:00', ('M,W,R'), 30360, 74, 14, 14, 4),
('CS', 2510, 'Fundementals of Computer Science 2', '9:15:00', '10:20:00', ('M,W,R'), 32084, 89, 15, 15, 4),

('CS', 2800, 'Logic and Computation', '10:30:00', '11:35:00', ('M,W,R'), 30094, 80, 18, 17, 4),
('CS', 2800, 'Logic and Computation', '10:30:00', '11:35:00', ('M,W,R'), 30093, 80, 19, 18, 4),
('CS', 2800, 'Logic and Computation', '10:30:00', '11:35:00', ('M,W,R'), 34677, 80, 20, 17, 4);

INSERT INTO
prof_reg
VALUES
(1, 1, 31617),
(2, 1, 31618),
(12, 1, 30414),
(12, 2, 33633),
(13, 1, 35013),
(13, 2, 37433),
(10, 1, 30567),
(11, 1, 34670),
(11, 2, 35012),
(14, 1, 30361),
(14, 2, 30360),
(15, 1, 32084),
(18, 1, 30094),
(19, 1, 30093),
(20, 1, 34677);

INSERT INTO
student_history
VALUES
(1, 1, 13502, 'CS', 2500),
(1, 2, 10650, 'CS', 1800),
(2, 1, 14133, 'CS', 2500),
(2, 2, 10650, 'CS', 1800),
(3, 1, 16297, 'CS', 2500),
(3, 2, 16283, 'CS', 1800);

INSERT INTO
student_reg
VALUES
(1, 1, 30361),
(1, 2, 30094),
(2, 1, 30360),
(2, 2, 30093),
(3, 1, 32084),
(3, 2, 30093),
(4, 1, 30567),
(5, 1, 30567),
(6, 1, 30567),
(7, 1, 30567),
(8, 1, 30567),
(9, 1, 30567),
(10, 1, 30567),
(11, 1, 30567),
(12, 1, 30567);