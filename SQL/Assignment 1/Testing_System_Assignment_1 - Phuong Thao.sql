DROP DATABASE IF EXISTS Testingsystemassignment_1;
CREATE DATABASE Testingsystemassignment_1;
USE Testingsystemassignment_1;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Departmentname VARCHAR(30) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS Position;
CREATE TABLE Position (
	PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Positionname ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
	AccountID SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Email VARCHAR(255) NOT NULL UNIQUE KEY,
	Username VARCHAR(255) NOT NULL UNIQUE KEY,
	Fullname VARCHAR(50) NOT NULL,
	DepartmentID TINYINT UNSIGNED NOT NULL,
	PositionID TINYINT UNSIGNED NOT NULL,
FOREIGN KEY(DepartmentID) REFERENCES `Department`(DepartmentID),
FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID),
	Createdate DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	GroupID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Groupname VARCHAR(255) NOT NULL UNIQUE KEY,
	CreatorID SMALLINT UNSIGNED,
	CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)  	
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
    GroupID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    AccountID SMALLINT UNSIGNED NOT NULL,
    JoinDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
	TypeID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Typename ENUM("Essay","Multiple-Choice") NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion (
	CategoryID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Categoryname ENUM("Java.",".NET","SQL","Postman","Ruby","...") NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
	QuestionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content VARCHAR(255) NOT NULL UNIQUE KEY,
    CategoryID TINYINT UNSIGNED NOT NULL,
	TypeID TINYINT UNSIGNED NOT NULL,
	CreatorID SMALLINT UNSIGNED,
	CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
	FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY (CreatorID) REFERENCES `account`(AccountID)
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
	AnswerID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content VARCHAR(255) NOT NULL,
	QuestionID TINYINT UNSIGNED NOT NULL,
	isCorrect BIT DEFAULT 1,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
	ExamID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`Code` CHAR(10) NOT NULL,
	Title VARCHAR(255) NOT NULL UNIQUE KEY,
	CategoryID TINYINT UNSIGNED NOT NULL,
	Duration TINYINT UNSIGNED NOT NULL,
	CreatorID SMALLINT UNSIGNED NOT NULL,
	Createdate DATETIME DEFAULT NOW(),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES `account`(AccountID)
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion (
	ExamID TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
	QuestionID TINYINT UNSIGNED,
FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID),
PRIMARY KEY (ExamID,QuestionID)
);

INSERT INTO Department (Departmentname)
VALUES 
		('Giam doc'),
        ('Tai chinh'),
        ('Nhan su'),
        ('Marketing'),
        ('IT');

INSERT INTO position (positionname)
VALUES 
		('Dev'),
        ('Scrum Master'),
        ('Test'),
        ('PM');

SELECT * FROM department;
SELECT * FROM position;

INSERT INTO `account`(Email,            Username, 		Fullname, 			DepartmentID, 	PositionID)
VALUES  			('Dalia1@vti.com', 		'thao1',	'thao nguyen1',		1,				1),
					('Dalia2@vti.com', 		'thao2',	'thao nguyen2',		2,				3),
                    ('Dalia3@vti.com', 		'thao3',	'thao nguyen3',		3,				2),
                    ('Dalia4@vti.com', 		'thao4',	'thao nguyen4',		4,				4),
                    ('Dalia5@vti.com', 		'thao5',	'thao nguyen5',		5,				1);
                    
INSERT INTO `group`(Groupname, 		CreatorID, 			Createdate)
VALUES  			('A', 				1,				'2022-07-19'),
					('B', 				2,				'2022-07-20'),
					('C', 				3,				'2022-07-21'),
                    ('D', 				4,				'2022-07-22'),
					('E', 				5,				'2022-07-23');
                    
INSERT INTO `Groupaccount`(GroupID, 		AccountID, 			Joindate)
VALUES  					(5, 				1,				'2022-07-19'),
							(4, 				2,				'2022-07-20'),
							(3, 				3,				'2022-07-21'),
							(2, 				4,				'2022-07-22'),
							(1, 				5,				'2022-07-23');
                            
INSERT INTO `TypeQuestion`(Typename)
VALUES  				('Essay'),
						('Multiple-Choice');
                        
INSERT INTO `CategoryQuestion`(Categoryname)
VALUES  				('Java.'),
						('Postman'),
                        ('SQL'),
                        ('.NET'),
                        ('Ruby');
                        
INSERT INTO `Question`(Content, 		CategoryID, 		TypeID,			CreatorID,			Createdate)
VALUES  			('Hoi ve Java', 			1,				1,				2,						'2022-07-19'),
					('Hoi ve Postman', 			2,				2,				3,						'2022-07-20'),
					('Hoi ve SQL', 			    3,				1,				1,						'2022-07-21'),
                    ('Hoi ve .NET', 			4,				2,				5,						'2022-07-22'),
					('Hoi ve Ruby', 			5,				1,				4,						'2022-07-23');

INSERT INTO `Answer`(Content, 		QuestionID, 			isCorrect)
VALUES  			('Tra loi 1', 				5,				0),
					('Tra loi 2', 				1,				1),
					('Tra loi 3', 				2,				0),
					('Tra loi 4', 				3,				1),
					('Tra loi 5', 				4,				0);
				
INSERT INTO `Exam`(`Code`, 				Title,					CategoryID,			Duration,	CreatorID, 	Createdate)
VALUES  			('DALIA1', 			'De thi Java',				5,				60,				5,		'2022-07-19'),
					('DALIA2', 			'De thi Postman',			4,			    120,			3,			'2022-07-20'),
					('DALIA3', 			'De thi SQL',				3,				60,				2,		'2022-07-21'),
                    ('DALIA4', 			'De thi .NET',				2,				60,				1,		'2022-07-22'),
					('DALIA5', 			'De thi Ruby',				1,				120,			4,			'2022-07-23');
                    
INSERT INTO ExamQuestion(ExamID, 		QuestionID)
VALUES  					(5, 				1),
							(4, 				2),
                            (3, 				3),
                            (2, 				4),
                            (1, 				5);


                    