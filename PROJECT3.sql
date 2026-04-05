USE SCHOOL;
GO
SELECT name FROM sys.tables;

--1) DEPARTMENT 
CREATE TABLE DEPARTMENT (
    DEPARTMENTID    INT PRIMARY KEY,
    DEPARTMENTNAME  VARCHAR(50) NOT NULL
);
GO

-- 2) COURSE
CREATE TABLE COURSE (
    COURSEID        INT PRIMARY KEY,
    COURSENAME      VARCHAR(100) NOT NULL,
    DESCRIPTION     VARCHAR(MAX),
    GRADELEVEL      INT CHECK (GRADELEVEL BETWEEN 1 AND 12)
);
GO

-- 3) TEACHER
CREATE TABLE TEACHER (
    TEACHERID       INT PRIMARY KEY,
    DEPARTMENTID    INT NOT NULL,
    FIRSTNAME       VARCHAR(50) NOT NULL,
    LASTNAME        VARCHAR(50) NOT NULL,
    EMAIL           VARCHAR(100) UNIQUE,
    CONTACTNUMBER   VARCHAR(20),
    CONSTRAINT FK_TEACHER_DEPT FOREIGN KEY (DEPARTMENTID) REFERENCES DEPARTMENT(DEPARTMENTID)
);
GO

-- 4) STUDENT
CREATE TABLE STUDENT (
    STUDENTID       INT PRIMARY KEY,
    FIRSTNAME       VARCHAR(50) NOT NULL,
    LASTNAME        VARCHAR(50) NOT NULL,
    DATEOFBIRTH     DATE NOT NULL,
    GRADELEVEL      INT NOT NULL CHECK (GRADELEVEL BETWEEN 1 AND 12),
    ADDRESS          VARCHAR(100),
    CONTACTNUMBER   VARCHAR(20)
);
GO

-- 5) OFERING
CREATE TABLE OFERING (
    OFERINGID        INT PRIMARY KEY,
    COURSEID         INT NOT NULL,
    TEACHERID       INT NOT NULL,
    DAYOFWEEK       VARCHAR(10) NOT NULL CHECK (DAYOFWEEK IN
                        ('SUNDAY','MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY')),
    STARTTIME       TIME NOT NULL,
    ENDTIME         TIME NOT NULL,
    ROOMNUMBER      VARCHAR(20),
    CHECK (ENDTIME > STARTTIME),
    FOREIGN KEY (COURSEID) REFERENCES COURSE(COURSEID),
    FOREIGN KEY (TEACHERID) REFERENCES TEACHER(TEACHERID)
);
GO

--6) ENROLLMENT
CREATE TABLE ENROLLMENT (
    STUDENTID       INT NOT NULL,
    OFERINGID       INT NOT NULL,
    SCORE           DECIMAL(5,2) NOT NULL CHECK (SCORE >= 0 AND SCORE <= 100),
    GRADE           CHAR(1),
    ENROLLMENTDATE  DATE DEFAULT CAST(GETDATE() AS DATE),
    PRIMARY KEY (STUDENTID, OFERINGID),
    FOREIGN KEY (STUDENTID) REFERENCES STUDENT(STUDENTID),
    FOREIGN KEY (OFERINGID)  REFERENCES OFERING(OFERINGID)
);
GO

--7) GUARDIAN
CREATE TABLE GUARDIAN (
    GUARDIANID      INT PRIMARY KEY,
    FIRSTNAME       VARCHAR(50) NOT NULL,
    LASTNAME        VARCHAR(50) NOT NULL,
    RELATIONSHIP    VARCHAR(50) NOT NULL,
    CONTACTNUMBER   VARCHAR(20),
    EMAIL           VARCHAR(100)
);
GO

-- 8) STUDENT_GUARDIAN (M:N)
CREATE TABLE STUDENT_GUARDIAN (
    STUDENTID       INT NOT NULL,
    GUARDIANID      INT NOT NULL,
    PRIMARY KEY (STUDENTID, GUARDIANID),
    FOREIGN KEY (STUDENTID) REFERENCES STUDENT(STUDENTID),
    FOREIGN KEY (GUARDIANID) REFERENCES GUARDIAN(GUARDIANID)
);
GO



--INSERTING 
INSERT INTO DEPARTMENT (DEPARTMENTID, DEPARTMENTNAME) VALUES
(1,'Mathematics'),
(2,'Science'),
(3,'Languages'),
(4,'Computer Science'),
(5,'Social Studies');


INSERT INTO COURSE VALUES
(1,'Mathematics 1','Algebra basics',7),
(2,'Mathematics 2','Geometry',8),
(3,'Physics','Intro Physics',10),
(4,'Chemistry','Basic Chemistry',10),
(5,'Biology','Life Science',9),
(6,'English Grammar','Grammar',7),
(7,'English Literature','Stories',9),
(8,'Arabic Language','Arabic Grammar',8),
(9,'Computer Basics','Intro CS',7),
(10,'Programming 1','C Programming',10),
(11,'Programming 2','OOP',11),
(12,'History','World History',8),
(13,'Geography','Geography',7),
(14,'Statistics','Statistics',11),
(15,'ICT','IT Fundamentals',9);


INSERT INTO TEACHER VALUES
(1,1,'Ahmed','Hassan','ahmed@school.com','01010000001'),
(2,1,'Mona','Ali','mona@school.com','01010000002'),
(3,2,'Khaled','Samir','khaled@school.com','01010000003'),
(4,2,'Salma','Youssef','salma@school.com','01010000004'),
(5,2,'Omar','Fathy','omar@school.com','01010000005'),
(6,3,'Nour','Adel','nour@school.com','01010000006'),
(7,3,'Dina','Mahmoud','dina@school.com','01010000007'),
(8,3,'Hany','Mostafa','hany@school.com','01010000008'),
(9,4,'Sara','Ibrahim','sara@school.com','01010000009'),
(10,4,'Yousef','Ashraf','yousef@school.com','01010000010'),
(11,4,'Tamer','Nabil','tamer@school.com','01010000011'),
(12,5,'Rania','Said','rania@school.com','01010000012'),
(13,5,'Maher','Lotfy','maher@school.com','01010000013'),
(14,5,'Laila','Farouk','laila@school.com','01010000014'),
(15,1,'Mostafa','Ehab','mostafa@school.com','01010000015');

--good greads students 
INSERT INTO STUDENT VALUES
(1,'Ali','Hassan','2010-02-15',7,'Cairo','01220000001'),
(2,'Omar','Mahmoud','2009-03-20',8,'Giza','01220000002'),
(3,'Youssef','Ahmed','2010-06-11',7,'Cairo','01220000003'),
(4,'Kareem','Mostafa','2008-09-05',9,'Alex','01220000004'),
(5,'Adel','Samir','2009-01-22',8,'Cairo','01220000005'),
(6,'Hassan','Ali','2010-04-18',7,'Giza','01220000006'),
(7,'Mahmoud','Tamer','2008-12-09',9,'Cairo','01220000007'),
(8,'Amr','Fathy','2009-07-14',8,'Alex','01220000008'),
(9,'Ibrahim','Sayed','2010-10-01',7,'Cairo','01220000009'),
(10,'Mina','Nabil','2008-11-30',9,'Giza','01220000010'),

(11,'Nour','Hany','2009-02-17',8,'Cairo','01220000011'),
(12,'Salma','Adel','2010-05-26',7,'Alex','01220000012'),
(13,'Farah','Youssef','2008-08-19',9,'Cairo','01220000013'),
(14,'Laila','Ahmed','2009-03-03',8,'Giza','01220000014'),
(15,'Sara','Mostafa','2010-12-12',7,'Cairo','01220000015'),
(16,'Nada','Hassan','2008-06-27',9,'Alex','01220000016'),
(17,'Rana','Ali','2009-09-09',8,'Cairo','01220000017'),
(18,'Jana','Mahmoud','2010-01-21',7,'Giza','01220000018'),
(19,'Malak','Samir','2008-04-04',9,'Cairo','01220000019'),
(20,'Aya','Fathy','2009-11-16',8,'Alex','01220000020'),

(21,'Ziad','Omar','2010-02-02',7,'Cairo','01220000021'),
(22,'Adam','Hassan','2009-06-18',8,'Giza','01220000022'),
(23,'Yassin','Ali','2008-10-25',9,'Cairo','01220000023'),
(24,'Seif','Mahmoud','2009-01-09',8,'Alex','01220000024'),
(25,'Mostafa','Tarek','2010-03-30',7,'Cairo','01220000025'),
(26,'Hady','Nabil','2008-07-07',9,'Giza','01220000026'),
(27,'Khaled','Samy','2009-05-15',8,'Cairo','01220000027'),
(28,'Bilal','Ashraf','2010-09-28',7,'Alex','01220000028'),
(29,'Yehia','Sameh','2008-12-01',9,'Cairo','01220000029'),
(30,'Ramy','Hossam','2009-04-22',8,'Giza','01220000030'),

(31,'Othman','Ayman','2010-06-06',7,'Cairo','01220000031'),
(32,'Fares','Kamal','2009-08-19',8,'Alex','01220000032'),
(33,'Hamza','Said','2008-02-11',9,'Cairo','01220000033'),
(34,'Anas','Lotfy','2009-10-14',8,'Giza','01220000034'),
(35,'Badr','Hany','2010-01-03',7,'Cairo','01220000035'),
(36,'Zain','Mostafa','2008-06-29',9,'Alex','01220000036'),
(37,'Sami','Yasser','2009-12-20',8,'Cairo','01220000037'),
(38,'Taha','Rashad','2010-05-08',7,'Giza','01220000038'),
(39,'Laith','Maged','2008-09-17',9,'Cairo','01220000039'),
(40,'Naseem','Ihab','2009-03-27',8,'Alex','01220000040'),

(41,'Fadi','Othman','2010-11-11',7,'Cairo','01220000041'),
(42,'Sultan','Ali','2008-01-30',9,'Giza','01220000042'),
(43,'Halim','Nasser','2009-07-23',8,'Cairo','01220000043'),
(44,'Qasem','Fouad','2010-04-04',7,'Alex','01220000044'),
(45,'Rashed','Saber','2008-10-19',9,'Cairo','01220000045'),
(46,'Ammar','Ehab','2009-12-02',8,'Giza','01220000046'),
(47,'Zuhayr','Tamer','2010-02-14',7,'Cairo','01220000047'),
(48,'Kinan','Sami','2008-05-06',9,'Alex','01220000048'),
(49,'Murad','Hatem','2009-09-29',8,'Cairo','01220000049'),
(50,'Yaman','Adnan','2010-07-01',7,'Giza','01220000050'),

(51,'Hussein','Latif','2008-03-18',9,'Cairo','01220000051'),
(52,'Naji','Ismail','2009-06-12',8,'Alex','01220000052'),
(53,'Fouad','Reda','2010-10-22',7,'Cairo','01220000053'),
(54,'Majd','Hisham','2008-08-05',9,'Giza','01220000054'),
(55,'Tariq','Basel','2009-11-09',8,'Cairo','01220000055'),
(56,'Rauf','Saad','2010-01-19',7,'Alex','01220000056'),
(57,'Salem','Karam','2008-06-14',9,'Cairo','01220000057'),
(58,'Aref','Zaki','2009-04-28',8,'Giza','01220000058'),
(59,'Munir','Fahmy','2010-12-03',7,'Cairo','01220000059'),
(60,'Samer','Bassem','2008-02-26',9,'Alex','01220000060');

--bad greads students 
INSERT INTO STUDENT VALUES
(61,'Karim','Hassan','2009-02-10',8,'Cairo','01220000061'),
(62,'Hatem','Ali','2010-04-21',7,'Giza','01220000062'),
(63,'Nader','Mahmoud','2008-08-30',9,'Alex','01220000063'),
(64,'Faris','Omar','2009-12-14',8,'Cairo','01220000064'),
(65,'Yazan','Samir','2010-06-06',7,'Giza','01220000065'),

(66,'Rami','Adel','2008-01-25',9,'Cairo','01220000066'),
(67,'Tariq','Fathy','2009-09-11',8,'Alex','01220000067'),
(68,'Ilyas','Nabil','2010-03-17',7,'Cairo','01220000068'),
(69,'Sufyan','Mostafa','2008-11-02',9,'Giza','01220000069'),
(70,'Zayn','Ashraf','2009-05-28',8,'Alex','01220000070'),

(71,'Bilal','Sayed','2007-10-10',10,'Cairo','01220000071'),
(72,'Anwar','Hossam','2007-02-19',10,'Giza','01220000072'),
(73,'Laith','Reda','2006-12-03',11,'Alex','01220000073'),
(74,'Omar','Basel','2006-04-22',11,'Cairo','01220000074'),
(75,'Hisham','Karam','2007-08-15',10,'Giza','01220000075'),

(76,'Salim','Zaki','2006-09-09',11,'Alex','01220000076'),
(77,'Amjad','Latif','2007-01-18',10,'Cairo','01220000077'),
(78,'Qadir','Ismail','2008-07-27',9,'Giza','01220000078'),
(79,'Fawwaz','Fahmy','2009-11-05',8,'Cairo','01220000079'),
(80,'Rashid','Bassem','2010-02-01',7,'Alex','01220000080');



INSERT INTO GUARDIAN VALUES
(1,'Hassan','Ali','Father','01130000001','g1@mail.com'),
(2,'Mona','Ali','Mother','01130000002','g2@mail.com'),
(3,'Mahmoud','Omar','Father','01130000003','g3@mail.com'),
(4,'Hala','Omar','Mother','01130000004','g4@mail.com'),
(5,'Ahmed','Youssef','Father','01130000005','g5@mail.com'),
(6,'Nour','Youssef','Mother','01130000006','g6@mail.com'),
(7,'Mostafa','Kareem','Father','01130000007','g7@mail.com'),
(8,'Salma','Kareem','Mother','01130000008','g8@mail.com'),
(9,'Samir','Adel','Father','01130000009','g9@mail.com'),
(10,'Dina','Adel','Mother','01130000010','g10@mail.com'),

(11,'Ali','Hassan','Father','01130000011','g11@mail.com'),
(12,'Reem','Hassan','Mother','01130000012','g12@mail.com'),
(13,'Tamer','Mahmoud','Father','01130000013','g13@mail.com'),
(14,'Rania','Mahmoud','Mother','01130000014','g14@mail.com'),
(15,'Fathy','Amr','Father','01130000015','g15@mail.com'),
(16,'Laila','Amr','Mother','01130000016','g16@mail.com'),
(17,'Sayed','Ibrahim','Father','01130000017','g17@mail.com'),
(18,'Heba','Ibrahim','Mother','01130000018','g18@mail.com'),
(19,'Nabil','Mina','Father','01130000019','g19@mail.com'),
(20,'Mariam','Mina','Mother','01130000020','g20@mail.com'),

-- single guardians (21 → 80)
(21,'Omar','Ziad','Father','01130000021','g21@mail.com'),
(22,'Hassan','Adam','Father','01130000022','g22@mail.com'),
(23,'Ali','Yassin','Father','01130000023','g23@mail.com'),
(24,'Mahmoud','Seif','Father','01130000024','g24@mail.com'),
(25,'Tarek','Mostafa','Father','01130000025','g25@mail.com'),
(26,'Nabil','Hady','Father','01130000026','g26@mail.com'),
(27,'Samy','Khaled','Father','01130000027','g27@mail.com'),
(28,'Ashraf','Bilal','Father','01130000028','g28@mail.com'),
(29,'Sameh','Yehia','Father','01130000029','g29@mail.com'),
(30,'Hossam','Ramy','Father','01130000030','g30@mail.com'),

(31,'Ayman','Othman','Father','01130000031','g31@mail.com'),
(32,'Kamal','Fares','Father','01130000032','g32@mail.com'),
(33,'Said','Hamza','Father','01130000033','g33@mail.com'),
(34,'Lotfy','Anas','Father','01130000034','g34@mail.com'),
(35,'Hany','Badr','Father','01130000035','g35@mail.com'),
(36,'Mostafa','Zain','Father','01130000036','g36@mail.com'),
(37,'Yasser','Sami','Father','01130000037','g37@mail.com'),
(38,'Rashad','Taha','Father','01130000038','g38@mail.com'),
(39,'Maged','Laith','Father','01130000039','g39@mail.com'),
(40,'Ihab','Naseem','Father','01130000040','g40@mail.com'),

(41,'Othman','Fadi','Father','01130000041','g41@mail.com'),
(42,'Ali','Sultan','Father','01130000042','g42@mail.com'),
(43,'Nasser','Halim','Father','01130000043','g43@mail.com'),
(44,'Fouad','Qasem','Father','01130000044','g44@mail.com'),
(45,'Saber','Rashed','Father','01130000045','g45@mail.com'),
(46,'Ehab','Ammar','Father','01130000046','g46@mail.com'),
(47,'Tamer','Zuhayr','Father','01130000047','g47@mail.com'),
(48,'Sami','Kinan','Father','01130000048','g48@mail.com'),
(49,'Hatem','Murad','Father','01130000049','g49@mail.com'),
(50,'Adnan','Yaman','Father','01130000050','g50@mail.com'),

(51,'Latif','Hussein','Father','01130000051','g51@mail.com'),
(52,'Ismail','Naji','Father','01130000052','g52@mail.com'),
(53,'Reda','Fouad','Father','01130000053','g53@mail.com'),
(54,'Hisham','Majd','Father','01130000054','g54@mail.com'),
(55,'Basel','Tariq','Father','01130000055','g55@mail.com'),
(56,'Saad','Rauf','Father','01130000056','g56@mail.com'),
(57,'Karam','Salem','Father','01130000057','g57@mail.com'),
(58,'Zaki','Aref','Father','01130000058','g58@mail.com'),
(59,'Fahmy','Munir','Father','01130000059','g59@mail.com'),
(60,'Bassem','Samer','Father','01130000060','g60@mail.com'),
(61,'Extra','Guardian1','Father','01130000061','g61@mail.com'),
(62,'Extra','Guardian2','Father','01130000062','g62@mail.com'),
(63,'Extra','Guardian3','Father','01130000063','g63@mail.com'),
(64,'Extra','Guardian4','Father','01130000064','g64@mail.com'),
(65,'Extra','Guardian5','Father','01130000065','g65@mail.com'),
(66,'Extra','Guardian6','Father','01130000066','g66@mail.com'),
(67,'Extra','Guardian7','Father','01130000067','g67@mail.com'),
(68,'Extra','Guardian8','Father','01130000068','g68@mail.com'),
(69,'Extra','Guardian9','Father','01130000069','g69@mail.com'),
(70,'Extra','Guardian10','Father','01130000070','g70@mail.com'),
(71,'Extra','Guardian11','Father','01130000071','g71@mail.com'),
(72,'Extra','Guardian12','Father','01130000072','g72@mail.com'),
(73,'Extra','Guardian13','Father','01130000073','g73@mail.com'),
(74,'Extra','Guardian14','Father','01130000074','g74@mail.com'),
(75,'Extra','Guardian15','Father','01130000075','g75@mail.com'),
(76,'Extra','Guardian16','Father','01130000076','g76@mail.com'),
(77,'Extra','Guardian17','Father','01130000077','g77@mail.com'),
(78,'Extra','Guardian18','Father','01130000078','g78@mail.com'),
(79,'Extra','Guardian19','Father','01130000079','g79@mail.com'),
(80,'Extra','Guardian20','Father','01130000080','g80@mail.com');


INSERT INTO GUARDIAN VALUES
(81,'Extra','Guardian21','Father','01130000081','g81@mail.com'),
(82,'Extra','Guardian22','Father','01130000082','g82@mail.com'),
(83,'Extra','Guardian23','Father','01130000083','g83@mail.com'),
(84,'Extra','Guardian24','Father','01130000084','g84@mail.com'),
(85,'Extra','Guardian25','Father','01130000085','g85@mail.com'),
(86,'Extra','Guardian26','Father','01130000086','g86@mail.com'),
(87,'Extra','Guardian27','Father','01130000087','g87@mail.com'),
(88,'Extra','Guardian28','Father','01130000088','g88@mail.com'),
(89,'Extra','Guardian29','Father','01130000089','g89@mail.com'),
(90,'Extra','Guardian30','Father','01130000090','g90@mail.com'),

(91,'Extra','Guardian31','Father','01130000091','g91@mail.com'),
(92,'Extra','Guardian32','Father','01130000092','g92@mail.com'),
(93,'Extra','Guardian33','Father','01130000093','g93@mail.com'),
(94,'Extra','Guardian34','Father','01130000094','g94@mail.com'),
(95,'Extra','Guardian35','Father','01130000095','g95@mail.com'),
(96,'Extra','Guardian36','Father','01130000096','g96@mail.com'),
(97,'Extra','Guardian37','Father','01130000097','g97@mail.com'),
(98,'Extra','Guardian38','Father','01130000098','g98@mail.com'),
(99,'Extra','Guardian39','Father','01130000099','g99@mail.com'),
(100,'Extra','Guardian40','Father','01130000100','g100@mail.com');




INSERT INTO OFERING 
(OFERINGID, COURSEID, TEACHERID, DAYOFWEEK, STARTTIME, ENDTIME, ROOMNUMBER)
VALUES
(1,1,1,'SUNDAY','08:00','09:30','R101'),
(2,3,3,'MONDAY','10:00','11:30','R102'),
(3,5,5,'TUESDAY','12:00','13:30','R103'),

(4,7,6,'SUNDAY','08:00','09:30','R201'),
(5,9,9,'MONDAY','10:00','11:30','R202'),
(6,11,10,'TUESDAY','12:00','13:30','R203'),

(7,13,12,'WEDNESDAY','08:00','09:30','R301'),
(8,15,14,'THURSDAY','10:00','11:30','R302'),
(9,14,15,'FRIDAY','12:00','13:30','R303'); 

-- ADD MISSING OFERING RECORDS (TO PREVENT FK ERRORS)

INSERT INTO OFERING 
(OFERINGID, COURSEID, TEACHERID, DAYOFWEEK, STARTTIME, ENDTIME, ROOMNUMBER)
VALUES
(11, 2, 2, 'SUNDAY',    '10:00', '11:30', 'R104'),
(13, 4, 4, 'MONDAY',    '12:00', '13:30', 'R105'),
(15, 6, 6, 'TUESDAY',   '08:00', '09:30', 'R106'),
(17, 8, 8, 'WEDNESDAY', '10:00', '11:30', 'R107');
GO





INSERT INTO ENROLLMENT VALUES
(1,1,85,NULL,'2024-09-01'), (1,3,78,NULL,'2024-09-01'), (1,5,90,NULL,'2024-09-01'),
(2,1,70,NULL,'2024-09-01'), (2,3,82,NULL,'2024-09-01'), (2,5,88,NULL,'2024-09-01'),
(3,1,76,NULL,'2024-09-01'), (3,3,91,NULL,'2024-09-01'), (3,5,84,NULL,'2024-09-01'),
(4,1,89,NULL,'2024-09-01'), (4,3,73,NULL,'2024-09-01'), (4,5,80,NULL,'2024-09-01'),
(5,1,92,NULL,'2024-09-01'), (5,3,85,NULL,'2024-09-01'), (5,5,87,NULL,'2024-09-01'),

(6,1,81,NULL,'2024-09-01'), (6,3,79,NULL,'2024-09-01'), (6,5,90,NULL,'2024-09-01'),
(7,1,88,NULL,'2024-09-01'), (7,3,84,NULL,'2024-09-01'), (7,5,86,NULL,'2024-09-01'),
(8,1,75,NULL,'2024-09-01'), (8,3,82,NULL,'2024-09-01'), (8,5,91,NULL,'2024-09-01'),
(9,1,83,NULL,'2024-09-01'), (9,3,77,NULL,'2024-09-01'), (9,5,85,NULL,'2024-09-01'),
(10,1,90,NULL,'2024-09-01'), (10,3,88,NULL,'2024-09-01'), (10,5,92,NULL,'2024-09-01'),

(11,1,78,NULL,'2024-09-01'), (11,3,80,NULL,'2024-09-01'), (11,5,83,NULL,'2024-09-01'),
(12,1,85,NULL,'2024-09-01'), (12,3,89,NULL,'2024-09-01'), (12,5,87,NULL,'2024-09-01'),
(13,1,91,NULL,'2024-09-01'), (13,3,86,NULL,'2024-09-01'), (13,5,88,NULL,'2024-09-01'),
(14,1,74,NULL,'2024-09-01'), (14,3,79,NULL,'2024-09-01'), (14,5,81,NULL,'2024-09-01'),
(15,1,88,NULL,'2024-09-01'), (15,3,90,NULL,'2024-09-01'), (15,5,92,NULL,'2024-09-01'),

(16,1,82,NULL,'2024-09-01'), (16,3,85,NULL,'2024-09-01'), (16,5,87,NULL,'2024-09-01'),
(17,1,79,NULL,'2024-09-01'), (17,3,81,NULL,'2024-09-01'), (17,5,84,NULL,'2024-09-01'),
(18,1,86,NULL,'2024-09-01'), (18,3,88,NULL,'2024-09-01'), (18,5,90,NULL,'2024-09-01'),
(19,1,90,NULL,'2024-09-01'), (19,3,92,NULL,'2024-09-01'), (19,5,94,NULL,'2024-09-01'),
(20,1,84,NULL,'2024-09-01'), (20,3,86,NULL,'2024-09-01'), (20,5,88,NULL,'2024-09-01');

INSERT INTO ENROLLMENT VALUES
(21,7,80,NULL,'2024-09-01'), (21,9,85,NULL,'2024-09-01'), (21,11,88,NULL,'2024-09-01'),
(22,7,82,NULL,'2024-09-01'), (22,9,87,NULL,'2024-09-01'), (22,11,90,NULL,'2024-09-01'),
(23,7,78,NULL,'2024-09-01'), (23,9,81,NULL,'2024-09-01'), (23,11,85,NULL,'2024-09-01'),
(24,7,84,NULL,'2024-09-01'), (24,9,88,NULL,'2024-09-01'), (24,11,91,NULL,'2024-09-01'),
(25,7,86,NULL,'2024-09-01'), (25,9,90,NULL,'2024-09-01'), (25,11,92,NULL,'2024-09-01'),

(26,7,79,NULL,'2024-09-01'), (26,9,82,NULL,'2024-09-01'), (26,11,84,NULL,'2024-09-01'),
(27,7,83,NULL,'2024-09-01'), (27,9,85,NULL,'2024-09-01'), (27,11,88,NULL,'2024-09-01'),
(28,7,87,NULL,'2024-09-01'), (28,9,89,NULL,'2024-09-01'), (28,11,91,NULL,'2024-09-01'),
(29,7,81,NULL,'2024-09-01'), (29,9,84,NULL,'2024-09-01'), (29,11,86,NULL,'2024-09-01'),
(30,7,88,NULL,'2024-09-01'), (30,9,90,NULL,'2024-09-01'), (30,11,93,NULL,'2024-09-01'),

(31,7,82,NULL,'2024-09-01'), (31,9,85,NULL,'2024-09-01'), (31,11,88,NULL,'2024-09-01'),
(32,7,84,NULL,'2024-09-01'), (32,9,87,NULL,'2024-09-01'), (32,11,90,NULL,'2024-09-01'),
(33,7,86,NULL,'2024-09-01'), (33,9,89,NULL,'2024-09-01'), (33,11,92,NULL,'2024-09-01'),
(34,7,79,NULL,'2024-09-01'), (34,9,82,NULL,'2024-09-01'), (34,11,85,NULL,'2024-09-01'),
(35,7,88,NULL,'2024-09-01'), (35,9,90,NULL,'2024-09-01'), (35,11,93,NULL,'2024-09-01'),

(36,7,81,NULL,'2024-09-01'), (36,9,84,NULL,'2024-09-01'), (36,11,87,NULL,'2024-09-01'),
(37,7,83,NULL,'2024-09-01'), (37,9,86,NULL,'2024-09-01'), (37,11,89,NULL,'2024-09-01'),
(38,7,85,NULL,'2024-09-01'), (38,9,88,NULL,'2024-09-01'), (38,11,91,NULL,'2024-09-01'),
(39,7,87,NULL,'2024-09-01'), (39,9,90,NULL,'2024-09-01'), (39,11,92,NULL,'2024-09-01'),
(40,7,80,NULL,'2024-09-01'), (40,9,83,NULL,'2024-09-01'), (40,11,86,NULL,'2024-09-01');



INSERT INTO ENROLLMENT VALUES
-- 61–65 (weak students)
(61,1,48,NULL,'2024-09-01'), (61,3,52,NULL,'2024-09-01'), (61,5,45,NULL,'2024-09-01'),
(62,1,55,NULL,'2024-09-01'), (62,3,58,NULL,'2024-09-01'), (62,5,50,NULL,'2024-09-01'),
(63,1,42,NULL,'2024-09-01'), (63,3,46,NULL,'2024-09-01'), (63,5,40,NULL,'2024-09-01'),
(64,1,60,NULL,'2024-09-01'), (64,3,57,NULL,'2024-09-01'), (64,5,62,NULL,'2024-09-01'),
(65,1,49,NULL,'2024-09-01'), (65,3,51,NULL,'2024-09-01'), (65,5,47,NULL,'2024-09-01'),

-- 66–70 (borderline)
(66,1,63,NULL,'2024-09-01'), (66,3,65,NULL,'2024-09-01'), (66,5,61,NULL,'2024-09-01'),
(67,1,68,NULL,'2024-09-01'), (67,3,70,NULL,'2024-09-01'), (67,5,66,NULL,'2024-09-01'),
(68,1,59,NULL,'2024-09-01'), (68,3,62,NULL,'2024-09-01'), (68,5,60,NULL,'2024-09-01'),
(69,1,72,NULL,'2024-09-01'), (69,3,69,NULL,'2024-09-01'), (69,5,70,NULL,'2024-09-01'),
(70,1,65,NULL,'2024-09-01'), (70,3,67,NULL,'2024-09-01'), (70,5,64,NULL,'2024-09-01'),

-- 71–75 (mixed performance)
(71,1,58,NULL,'2024-09-01'), (71,3,61,NULL,'2024-09-01'), (71,5,55,NULL,'2024-09-01'),
(72,1,62,NULL,'2024-09-01'), (72,3,64,NULL,'2024-09-01'), (72,5,60,NULL,'2024-09-01'),
(73,1,47,NULL,'2024-09-01'), (73,3,50,NULL,'2024-09-01'), (73,5,45,NULL,'2024-09-01'),
(74,1,69,NULL,'2024-09-01'), (74,3,71,NULL,'2024-09-01'), (74,5,68,NULL,'2024-09-01'),
(75,1,66,NULL,'2024-09-01'), (75,3,63,NULL,'2024-09-01'), (75,5,65,NULL,'2024-09-01'),

-- 76–80 (lower-mid)
(76,1,54,NULL,'2024-09-01'), (76,3,57,NULL,'2024-09-01'), (76,5,52,NULL,'2024-09-01'),
(77,1,71,NULL,'2024-09-01'), (77,3,73,NULL,'2024-09-01'), (77,5,70,NULL,'2024-09-01'),
(78,1,46,NULL,'2024-09-01'), (78,3,48,NULL,'2024-09-01'), (78,5,44,NULL,'2024-09-01'),
(79,1,64,NULL,'2024-09-01'), (79,3,66,NULL,'2024-09-01'), (79,5,62,NULL,'2024-09-01'),
(80,1,57,NULL,'2024-09-01'), (80,3,59,NULL,'2024-09-01'), (80,5,56,NULL,'2024-09-01');




INSERT INTO STUDENT_GUARDIAN VALUES
(1,1),(1,2),(2,3),(2,4),(3,5),(3,6),(4,7),(4,8),
(5,9),(5,10),(6,11),(6,12),(7,13),(7,14),(8,15),(8,16),
(9,17),(9,18),(10,19),(10,20),
(11,21),(11,22),(12,23),(12,24),(13,25),(13,26),
(14,27),(14,28),(15,29),(15,30),(16,31),(16,32),
(17,33),(17,34),(18,35),(18,36),(19,37),(19,38),(20,39),(20,40);


INSERT INTO STUDENT_GUARDIAN VALUES
(21,41),(22,42),(23,43),(24,44),(25,45),(26,46),(27,47),(28,48),
(29,49),(30,50),(31,51),(32,52),(33,53),(34,54),(35,55),(36,56),
(37,57),(38,58),(39,59),(40,60),(41,61),(42,62),(43,63),(44,64),
(45,65),(46,66),(47,67),(48,68),(49,69),(50,70),(51,71),(52,72),
(53,73),(54,74),(55,75),(56,76),(57,77),(58,78),(59,79),(60,80);

INSERT INTO STUDENT_GUARDIAN VALUES
(61,81),(62,82),(63,83),(64,84),(65,85),
(66,86),(67,87),(68,88),(69,89),(70,90),
(71,91),(72,92),(73,93),(74,94),(75,95),
(76,96),(77,97),(78,98),(79,99),(80,100);


INSERT INTO ENROLLMENT VALUES
(41,13,82,NULL,'2024-09-01'), (41,15,85,NULL,'2024-09-01'), (41,17,88,NULL,'2024-09-01'),
(42,13,84,NULL,'2024-09-01'), (42,15,87,NULL,'2024-09-01'), (42,17,90,NULL,'2024-09-01'),
(43,13,86,NULL,'2024-09-01'), (43,15,89,NULL,'2024-09-01'), (43,17,92,NULL,'2024-09-01'),
(44,13,78,NULL,'2024-09-01'), (44,15,81,NULL,'2024-09-01'), (44,17,84,NULL,'2024-09-01'),
(45,13,88,NULL,'2024-09-01'), (45,15,90,NULL,'2024-09-01'), (45,17,93,NULL,'2024-09-01'),

(46,13,80,NULL,'2024-09-01'), (46,15,83,NULL,'2024-09-01'), (46,17,86,NULL,'2024-09-01'),
(47,13,82,NULL,'2024-09-01'), (47,15,85,NULL,'2024-09-01'), (47,17,88,NULL,'2024-09-01'),
(48,13,84,NULL,'2024-09-01'), (48,15,87,NULL,'2024-09-01'), (48,17,90,NULL,'2024-09-01'),
(49,13,86,NULL,'2024-09-01'), (49,15,89,NULL,'2024-09-01'), (49,17,92,NULL,'2024-09-01'),
(50,13,88,NULL,'2024-09-01'), (50,15,90,NULL,'2024-09-01'), (50,17,93,NULL,'2024-09-01'),

(51,13,81,NULL,'2024-09-01'), (51,15,84,NULL,'2024-09-01'), (51,17,87,NULL,'2024-09-01'),
(52,13,83,NULL,'2024-09-01'), (52,15,86,NULL,'2024-09-01'), (52,17,89,NULL,'2024-09-01'),
(53,13,85,NULL,'2024-09-01'), (53,15,88,NULL,'2024-09-01'), (53,17,91,NULL,'2024-09-01'),
(54,13,87,NULL,'2024-09-01'), (54,15,90,NULL,'2024-09-01'), (54,17,93,NULL,'2024-09-01'),
(55,13,80,NULL,'2024-09-01'), (55,15,83,NULL,'2024-09-01'), (55,17,86,NULL,'2024-09-01'),

(56,13,82,NULL,'2024-09-01'), (56,15,85,NULL,'2024-09-01'), (56,17,88,NULL,'2024-09-01'),
(57,13,84,NULL,'2024-09-01'), (57,15,87,NULL,'2024-09-01'), (57,17,90,NULL,'2024-09-01'),
(58,13,86,NULL,'2024-09-01'), (58,15,89,NULL,'2024-09-01'), (58,17,92,NULL,'2024-09-01'),
(59,13,88,NULL,'2024-09-01'), (59,15,90,NULL,'2024-09-01'), (59,17,93,NULL,'2024-09-01'),
(60,13,81,NULL,'2024-09-01'), (60,15,84,NULL,'2024-09-01'), (60,17,87,NULL,'2024-09-01');


-- 1) CREATE FUNCTION TO ASSIGN GRADE BASED ON SCORE
GO
CREATE OR ALTER FUNCTION dbo.GetGrade (@Score DECIMAL(5,2))
RETURNS CHAR(1)
AS
BEGIN
    RETURN (
        SELECT CASE
            WHEN @Score >= 90 THEN 'A'
            WHEN @Score >= 80 THEN 'B'
            WHEN @Score >= 70 THEN 'C'
            WHEN @Score >= 60 THEN 'D'
            ELSE 'F'
        END
    );
END;
GO


-- 2) CREATE TRIGGER TO UPDATE GRADE ON INSERT OR UPDATE
GO
CREATE OR ALTER TRIGGER trg_SetGrade
ON ENROLLMENT
AFTER INSERT, UPDATE
AS
BEGIN
    -- Update the Grade column based on the Score using dbo.GetGrade
    UPDATE E
    SET E.Grade = dbo.GetGrade(E.Score)
    FROM ENROLLMENT E
    INNER JOIN inserted I
        ON E.StudentID = I.StudentID
       AND E.OFERINGID = I.OFERINGID;
END;
GO


-- 3) RUN THE TRIGGER FOR EXISTING RECORDS
-- This will ensure all current scores get their grade
UPDATE ENROLLMENT
SET Score = Score;
GO


-- ALL INFO ABOUT ALL STUDENTS WITH NUMBER OF COURSES
SELECT 
    S.StudentID, 
    S.FirstName, 
    S.LastName, 
    S.GradeLevel, 
    COUNT(E.OFERINGID) AS NumberOfCourses, 
    S.ContactNumber
FROM STUDENT S
LEFT JOIN ENROLLMENT E
    ON S.StudentID = E.StudentID
GROUP BY 
    S.StudentID, 
    S.FirstName, 
    S.LastName, 
    S.GradeLevel, 
    S.ContactNumber
ORDER BY S.StudentID;

-- STUDENT'S GUARDIANS AND THEIR CONTACT NUMBER AND ADDRESS
SELECT 
    S.StudentID,
    S.FirstName AS StudentFirstName,
    S.LastName AS StudentLastName,
    G.FirstName AS GuardianFirstName,
    G.LastName AS GuardianLastName,
    G.Relationship,
    G.ContactNumber AS GuardianContact,
    S.Address AS StudentAddress
FROM STUDENT S
LEFT JOIN STUDENT_GUARDIAN SG 
    ON S.StudentID = SG.StudentID
LEFT JOIN GUARDIAN G 
    ON G.GuardianID = SG.GuardianID
ORDER BY S.StudentID;

-- TOP STUDENT FROM EACH COURSE
SELECT 
    S.StudentID,
    S.FirstName,
    S.LastName,
    S.GradeLevel,
    C.CourseName,
    E.Grade,
    E.Score
FROM ENROLLMENT E
JOIN STUDENT S ON S.StudentID = E.StudentID
JOIN OFERING O ON O.OFERINGID = E.OFERINGID
JOIN COURSE C ON C.CourseID = O.CourseID
WHERE E.Score = (
    SELECT MAX(E2.Score)
    FROM ENROLLMENT E2
    JOIN OFERING O2 ON O2.OFERINGID = E2.OFERINGID
    WHERE O2.CourseID = O.CourseID)
ORDER BY C.CourseName, S.StudentID;


-- ALL INFO ABOUT ALL TEACHERS WITH THEIR COURSES
SELECT  
    T.TeacherID,
    T.FirstName,
    T.LastName,
    T.ContactNumber,
    T.Email,
    D.DepartmentName,
    C.CourseName
FROM TEACHER T
JOIN DEPARTMENT D ON T.DepartmentID = D.DepartmentID
LEFT JOIN OFERING O ON T.TeacherID = O.TeacherID
LEFT JOIN COURSE C ON O.CourseID = C.CourseID
ORDER BY T.TeacherID, C.CourseName;


-- SHOW SCHEDULE ORDERED BY DAY & TIME
SELECT *
FROM OFERING
ORDER BY CASE DAYOFWEEK
    WHEN 'SUNDAY'    THEN 1
    WHEN 'MONDAY'    THEN 2
    WHEN 'TUESDAY'   THEN 3
    WHEN 'WEDNESDAY' THEN 4
    WHEN 'THURSDAY'  THEN 5
    WHEN 'FRIDAY'    THEN 6
    WHEN 'SATURDAY'  THEN 7
END,
STARTTIME;


-- NUMBER OF STUDENTS IN EACH LEVEL WITH AVG SCORE
SELECT 
    S.GradeLevel,
    COUNT(DISTINCT S.StudentID) AS NumOfStudents,
    AVG(E.Score) AS AvgScore
FROM STUDENT S
LEFT JOIN ENROLLMENT E ON S.StudentID = E.StudentID
GROUP BY S.GradeLevel
ORDER BY S.GradeLevel;


-- STUDENTS WHO FAILED (GRADE 'F')   NO OUT PUT 
SELECT 
    S.StudentID,
    S.FirstName,
    S.LastName,
    E.Score,
    E.Grade
FROM STUDENT S
JOIN ENROLLMENT E ON S.StudentID = E.StudentID
WHERE E.Grade = 'F'
ORDER BY S.GradeLevel, E.Score DESC;


-- TEACHERS WHOSE CLASS AVERAGE < 75  NO OUTPUT 
SELECT 
    T.TeacherID,
    T.FirstName,
    T.LastName,
    AVG(E.Score) AS AverageScore
FROM TEACHER T
LEFT JOIN OFERING O 
ON T.TeacherID = O.TeacherID
LEFT JOIN ENROLLMENT E 
ON O.OFERINGID = E.OFERINGID
GROUP BY T.TeacherID, T.FirstName, T.LastName
HAVING AVG(E.Score) < 75;


-- STUDENTS WITH AT LEAST ONE SCORE >= 80  NO OUTPUT 
SELECT DISTINCT
    S.StudentID,
    S.FirstName,
    S.LastName ,
    E.SCORE
FROM STUDENT S
JOIN ENROLLMENT E ON S.StudentID = E.StudentID
WHERE E.Score >= 80
ORDER BY S.StudentID;


-- NUMBER OF COURSES EACH TEACHER IS TEACHING
SELECT 
    T.TeacherID,
    T.FirstName,
    T.LastName,
    COUNT(O.CourseID) AS NumCourses
FROM TEACHER T
LEFT JOIN OFERING O ON T.TeacherID = O.TeacherID
GROUP BY T.TeacherID, T.FirstName, T.LastName
ORDER BY NumCourses DESC;


-- NUMBER OF STUDENTS IN EACH COURSE
SELECT 
    C.CourseID,
    C.CourseName,
    COUNT(E.StudentID) AS NumStudents
FROM COURSE C
LEFT JOIN OFERING O ON C.CourseID = O.CourseID
LEFT JOIN ENROLLMENT E ON O.OFERINGID = E.OFERINGID
GROUP BY C.CourseID, C.CourseName
ORDER BY C.CourseID;

-- EACH CORSE EACH STUDENT ENRROLED IN 
SELECT S.FIRSTNAME,S.LASTNAME, S.GRADELEVEL, C.COURSENAME ,O.COURSEID
            FROM STUDENT S INNER JOIN ENROLLMENT E 
            ON E.STUDENTID = S.STUDENTID INNER JOIN OFERING O
            ON E.OFERINGID = O.OFERINGID INNER JOIN COURSE C
            ON C.COURSEID = O.COURSEID ;


            
SELECT 
    C.CourseID,
    C.CourseName,
    MAX(E.SCORE) AS TOP_GRADE
FROM COURSE C
LEFT JOIN OFERING O ON C.CourseID = O.CourseID
LEFT JOIN ENROLLMENT E ON O.OFERINGID = E.OFERINGID 
GROUP BY C.CourseID, C.CourseName 
ORDER BY C.CourseID;

