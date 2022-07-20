-- Tạo table
Drop DATABASE IF EXISTS Testing_System;
CREATE DATABASE Testing_System;
USE Testing_System;
-- Tạo table 1: Department
Drop table if exists Department;
CREATE TABLE Department (
	DepartmentID                 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName               VARCHAR(30) NOT NULL
    );
    -- Tạo table 2: POSITION
Drop table if exists POSITION;
CREATE TABLE POSITION (
	POSITIONID                 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    POSITIONName               ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL
    );
    -- Tạo table 3:  account
Drop table if exists Account; 
CREATE TABLE `Account` (
	AccountID                  TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    EMAIL                      Varchar(30) NOT NULL  UNIQUE KEY,
    Username                   Varchar(30) NOT NULL  UNIQUE KEY,
    Fullname                   Varchar(30) NOT NULL,
    DepartmentID               TINYINT UNSIGNED NOT NULL,
    PositionID                 TINYINT UNSIGNED NOT NULL,
    CreateDate                 DATETIME DEFAULT NOW(),
    FOREIGN KEY (DepartmentID) REFERENCES  Department (DepartmentID),
    FOREIGN KEY (PositionID ) REFERENCES  POSITION (POSITIONID)
    
    );
-- Tạo table 4: GROUP
Drop table if exists `GROUP`; 
CREATE TABLE `GROUP` (
	GROUPID                 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GROUPName               Varchar(30) NOT NULL UNIQUE KEY,
    CreatorID               TINYINT UNSIGNED NOT NULL,
    CreateDate              DATETIME DEFAULT CURRENT_TIMESTAMP()
	    );
-- Tạo table 5: GroupAccount
Drop table if exists `GroupAccount`; 
CREATE TABLE `GroupAccount` (
	GROUPID                 TINYINT UNSIGNED NOT NULL,
    AccountID               TINYINT UNSIGNED  NOT NULL,
    JoinDate                DATETIME DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY(GROUPID ) REFERENCES `GROUP`(GROUPID)
    
    );
    -- Tạo table 6: TypeQuetstion
    Drop table if exists TypeQuetstion; 
CREATE TABLE TypeQuetstion (
	TypeID                 TINYINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    TypeName               ENUM('Essay', 'Multiple-Choice' ) NOT NULL UNIQUE KEY
);
     
  -- Tạo table 7: CategoryQuestion
    Drop table if exists CategoryQuestion; 
CREATE TABLE CategoryQuestion (
	CategoryID              TINYINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    CategoryName               VARCHAR(30) NOT NULL UNIQUE KEY
    );
   
     -- Tạo table 8:  Question
Drop table if exists Question; 
CREATE TABLE `Question` (
	QuestionID                 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content                    Varchar(30) NOT NULL,
    CategoryID                 TINYINT UNSIGNED  NOT NULL,
    TypeID                     TINYINT UNSIGNED  NOT NULL,
	CreatorID                  TINYINT UNSIGNED NOT NULL,
    CreateDate                 DATETIME DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) REFERENCES  TypeQuetstion(TypeID), 
    FOREIGN KEY(CreatorID) REFERENCES  CategoryQuestion(CategoryID)
    );
        
  -- Tạo table 9: Answer
Drop table if exists `Answer`; 
CREATE TABLE `Answer` (
	AnswerID                TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content                Varchar(100) NOT NULL ,
    QuestionID             TINYINT UNSIGNED NOT NULL,
    isCorrect              ENUM('Đúng', 'Sai'),
	FOREIGN KEY(QuestionID) REFERENCES Question (QuestionID) 
    );    
      -- Tạo table 10: Exam
Drop table if exists `Exam`; 
CREATE TABLE `Exam` (
	ExamID                TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Code                  TINYINT UNSIGNED NOT NULL,
    Title                 Varchar(100) NOT NULL,
    CategoryID            TINYINT UNSIGNED NOT NULL,
	Duration              TINYINT UNSIGNED NOT NULL,
    CreatorID             TINYINT UNSIGNED NOT NULL,
    CreateDate            DATETIME DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion (CategoryID), 
    FOREIGN KEY(CreatorID) REFERENCES `GROUP` (CreatorID)
        );   
      -- Tạo table 11: ExamQuestion
Drop table if exists `ExamQuestion`; 
CREATE TABLE `ExamQuestion` (
	ExamID                TINYINT UNSIGNED NOT NULL,
    QuestionID            TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(ExamID) REFERENCES `Exam` (ExamID), 
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
    );   
    -- Insert 5 record vào mỗi bảng
    -- 1.INSERT INTO Department
    INSERT INTO Department(DepartmentName)
    VALUES                                  ('data1'),
                                            ('data2'),
                                            ('data3'),
                                            ('data4'),
                                            ('data5');
                                            
    
	-- 2.INSERT INTO POSITION
    INSERT INTO POSITION (POSITIONName)
	VALUES                                  ('Dev'),
											('Dev'),
											('Dev'),
											('Dev'),
											('Dev');
   
	-- 3.INSERT INTO Account
    INSERT INTO Account                    (EMAIL,                  Username,           Fullname,          DepartmentID,     PositionID)
    VALUES                                 ('email1@gmail.com',    'username1',        'fullname1',             1,            2),
										   ('email2@gmail.com',    'username2',        'fullname2',             2,            1),
                                           ('email3@gmail.com',    'username3',        'fullname3',             3,            4),
                                           ('email4@gmail.com',    'username4',        'fullname4',             1,            1),
                                           ('email5@gmail.com',    'username5',        'fullname5',             4,            1);
    -- 4.INSERT INTO GROUP
    INSERT INTO GROUP                      (GROUPName,          CreatorID)
	VALUES 								   ('GROUPName1',       '1'),
   							               ('GROUPName2',       '1'),
   								           ('GROUPName3',       '1'),
   							               ('GROUPName4',       '1'),
                 						   ('GROUPName5',       '1');
	-- 5.INSERT INTO 'GroupAccount'
    INSERT INTO 'GroupAccount'                      ( GROUPID,             AccountID ,         JoinDate  )
	VALUES 								            ('1',                   '1',              '2022-07-20'),
													('2',                   '2',              '2022-07-20'),
                                                    ('3',                   '3',              '2022-07-20'),
                                                    ('2',                   '4',              '2022-07-20'),
                                                    ('4',                   '5',              '2022-07-20');
                                                    
   				
	-- 6.INSERT INTO TypeQuetstion
    INSERT INTO TypeQuetstion(TypeName )
    VALUES                                          ('Essay'),
                                                    ('Multiple-Choice') ,
													('Essay'),
													('Essay')
                                                    ('Multiple-Choice' ) ;
    -- 7.INSERT INTO CategoryQuestion
    INSERT INTO CategoryQuestion(CategoryName)
    VAlUES                                         ('CategoryName1'),
												   ('CategoryName2'),
												   ('CategoryName3'),
                                                   ('CategoryName4'),
                                                   ('CategoryName5');
	-- 8.INSERT INTO Question
    INSERT INTO Question                           (Content,    CategoryID, TypeID, CreatorID, CreateDate)
    VALUES                                         ('Content1',  '1',        '1',     '1',      '2022-07-20'),
												   ('Content2',  '2',        '2',     '2',      '2022-07-20'),
												   ('Content1',  '3',        '3',     '3',      '2022-07-20'),
												   ('Content1',  '4',        '4',     '4',      '2022-07-20'),
												   ('Content1',  '5',        '3',     '3',      '2022-07-20') ;
                                                   
    
	-- 9.INSERT INTO Answer
	FOREIGN KEY(QuestionID) REFERENCES Question (QuestionID) 
    INSERT INTO Answer                            (Content,       QuestionID,        isCorrect)
    VALUES                                        ('Content1',     '1',              'Đúng'),
												  ('Content2',     '1',              'Đúng'),
                                                  ('Content3',     '2',              'Sai'),
												  ('Content4',     '3',              'Sai'),
												  ('Content5',     '2',              'Sai');
                                                  
    
    -- 10.INSERT INTO Exam
    INSERT INTO Exam                                (Code ,        Title,              CategoryID,     Duration,      CreatorID)
    VALUES                                          ('1',          'Title1',            '1',           '1',            '1'),
													('2',          'Title2',            '2',           '2',            '2'),
                                                    ('3',          'Title3',            '3',           '3',            '3'),
                                                    ('4',          'Title4',            '4',           '4',            '4'),
													('3',          'Title5',            '5',           '5',            '5');
                                                    
       
     -- 11.INSERT INTO  ExamQuestion
     INSERT INTO  ExamQuestion                      (ExamID,        QuestionID) 
     VALUES                                         ('1',            '1'),
                                                    ('2',            '2'),
                                                    ('3',            '3'),
                                                    ('4',            '4'),
                                                    ('5',            '5');
         
	
     
    
    
    