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
    CreateDate              DATETIME DEFAULT NOW(),
	FOREIGN KEY(CreatorID ) REFERENCES Account (AccountID) 
	    );
-- Tạo table 5: GroupAccount
Drop table if exists `GroupAccount`; 
CREATE TABLE `GroupAccount` (
   	GROUPID                 TINYINT UNSIGNED,
    AccountID               TINYINT UNSIGNED,
    JoinDate                DATETIME DEFAULT NOW(),
    PRIMARY KEY (GROUPID, AccountID), 
    FOREIGN KEY(GROUPID ) REFERENCES `GROUP`(GROUPID),
    FOREIGN KEY(AccountID) REFERENCES `Account` (AccountID )
    );
    -- Tạo table 6: TypeQuetstion
    Drop table if exists TypeQuestion; 
CREATE TABLE TypeQuestion (
	TypeID                 TINYINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    TypeName               ENUM('Essay', 'Multiple-Choice' ) NOT NULL UNIQUE KEY
);
     
  -- Tạo table 7: CategoryQuestion
    Drop table if exists CategoryQuestion; 
CREATE TABLE CategoryQuestion (
	CategoryID              TINYINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    CategoryName            VARCHAR(30) NOT NULL UNIQUE KEY
    );
   
     -- Tạo table 8:  Question
Drop table if exists Question; 
CREATE TABLE `Question` (
	QuestionID                 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content                    Varchar(30) NOT NULL,
    CategoryID                 TINYINT UNSIGNED  NOT NULL,
    TypeID                     TINYINT UNSIGNED  NOT NULL,
	CreatorID                  TINYINT UNSIGNED NOT NULL,
    CreateDate                 DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) REFERENCES  TypeQuestion(TypeID), 
    FOREIGN KEY(CreatorID) REFERENCES`Account`(AccountID)
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
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
        );   
      -- Tạo table 11: ExamQuestion
Drop table if exists `ExamQuestion`; 
CREATE TABLE `ExamQuestion` (
	ExamID                TINYINT UNSIGNED NOT NULL,
    QuestionID            TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(ExamID) REFERENCES `Exam` (ExamID), 
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
    );   
   
-- Question 1: Thêm ít nhất 10 record vào mỗi table
-- 1.INSERT INTO Department
    INSERT INTO Department(DepartmentName)
    VALUES                                  ('data1'),
                                            ('data2'),
                                            ('data3'),
                                            ('data4'),
                                            ('data5');
                                                                                       ;
                                            
    
	-- 2.INSERT INTO POSITION
    INSERT INTO POSITION (POSITIONName)
	VALUES                                  ('Dev'),
											('Dev'),
											('Dev'),
											('Dev'),
											('Dev'),
										    ('Test'),
											('Test'),
											('Test'),
											('Test'),
											('Test')
                                            ;
   
	-- 3.INSERT INTO Account
    INSERT INTO Account                    (EMAIL,                  Username,           Fullname,          DepartmentID,     PositionID)
    VALUES                                 ('email1@gmail.com',    'username1',        'fullname1',             1,            2),
										   ('email2@gmail.com',    'username2',        'fullname2',             2,            1),
                                           ('email3@gmail.com',    'username3',        'fullname3',             3,            4),
                                           ('email4@gmail.com',    'username4',        'fullname4',             1,            1),
                                           ('email5@gmail.com',    'username5',        'fullname5',             4,            1),
										   ('email6@gmail.com',    'username6',        'fullname6',             4,            1),
										   ('email7@gmail.com',    'username7',        'fullname7',             1,            1),
										   ('email8@gmail.com',    'username8',        'fullname8',             2,            4),
										   ('email9@gmail.com',    'username9',        'fullname9',             1,            3),
										   ('email10@gmail.com',   'username10',       'fullname10',             4,            1);
    -- 4.INSERT INTO GROUP
    INSERT INTO `GROUP`                      (GROUPName,          CreatorID)
	VALUES 								   ('GROUPName1',       1),
   							               ('GROUPName2',       1),
   								           ('GROUPName3',       1),
   							               ('GROUPName4',       1),
                 						   ('GROUPName5',       1),
                                           ('GROUPName1',       1),
   							               ('GROUPName2',       1),
   								           ('GROUPName3',       1),
   							               ('GROUPName4',       1),
                 						   ('GROUPName5',       1);
	-- 5.INSERT INTO 'GroupAccount'
    INSERT INTO GroupAccount                      ( GROUPID,             AccountID ,         JoinDate  )
	VALUES 								            (1,                   1,              '2022-07-20'),
													(2,                   2,              '2022-07-20'),
                                                    (3,                   3,              '2022-07-20'),
                                                    (2,                  4,              '2022-07-20'),
                                                    (4,                  5,              '2022-07-20'),
													(5,                   1,              '2022-07-20'),
													(6,                   2,              '2022-07-20'),
                                                    (7,                   3,              '2022-07-20'),
                                                    (8,                  4,              '2022-07-20'),
                                                    (9,                  5,              '2022-07-20');
                                                    
   				
	-- 6.INSERT INTO TypeQuestion
    INSERT INTO TypeQuestion(TypeName )
    VALUES                                          ('Essay'),
                                                    ('Multiple-Choice') ;
													
    -- 7.INSERT INTO CategoryQuestion
    INSERT INTO CategoryQuestion(CategoryName)
    VAlUES                                         ('CategoryName1'),
												   ('CategoryName2'),
												   ('CategoryName3'),
                                                   ('CategoryName4'),
                                                   ('CategoryName5'),
												   ('CategoryName6'),
												   ('CategoryName7'),
												   ('CategoryName8'),
                                                    ('CategoryName9'),
													('CategoryName10');
	-- 8.INSERT INTO Question
    INSERT INTO Question                           (Content,    CategoryID, TypeID, CreatorID, CreateDate)
    VALUES                                         ('Content1',  1,        1,     1,      '2022-07-20'),
												   ('Content2',  2,        2,     2,      '2022-07-20'),
												   ('Content1',  3,        1,     3,      '2022-07-20'),
												   ('Content1',  4,        1,     4,      '2022-07-20'),
												   ('Content1',  5,        2,     1,      '2022-07-20'),
                                                   ('Content1',  5,        2,     1,      '2022-07-20'),
                                                   ('Content1',  5,        2,     1,      '2022-07-20'),
                                                   ('Content1',  5,        2,     1,      '2022-07-20'),
                                                   ('Content1',  5,        2,     1,      '2022-07-20'),
                                                   ('Content1',  5,        2,     1,      '2022-07-20');
                                                   
    
	-- 9.INSERT INTO Answer
	INSERT INTO Answer                            (Content,       QuestionID,        isCorrect)
    VALUES                                        ('Content1',     1,              'Đúng'),
												  ('Content2',     1,              'Đúng'),
                                                  ('Content3',     1,              'Sai'),
												  ('Content4',     1,              'Sai'),
												  ('Content5',     1,              'Sai'),
                                                   ('Content6',     1,              'Đúng'),
												  ('Content7',     1,              'Đúng'),
                                                  ('Content8',     1,              'Sai'),
												  ('Content9',     1,              'Sai'),
												  ('Content10',     1,              'Sai');
                                                  
    
    -- 10.INSERT INTO Exam
    INSERT INTO Exam                                (Code ,        Title,              CategoryID,     Duration,      CreatorID)
    VALUES                                          (1,          'Title1',            1,           90,            1),
													(2,          'Title2',            2,           90,            2),
                                                    (3,          'Title3',            3,           60,            3),
                                                    (4,          'Title4',            4,           90,            4),
													(3,          'Title5',            5,           120,            5),
													(1,          'Title1',            1,           90,            1),
													(2,          'Title2',            2,           90,            2),
                                                    (3,          'Title3',            3,           60,            3),
                                                    (4,          'Title4',            4,           90,            4),
													(3,          'Title5',            5,           120,            5);											;
                                                    
    
     -- 11.INSERT INTO  ExamQuestion
     INSERT INTO  ExamQuestion                      (ExamID,        QuestionID) 
     VALUES                                         (1,            1),
                                                    (2,            2),
                                                    (3,            3),
                                                    (4,            4),
                                                    (5,            5),
                                                    (1,            1),
                                                    (2,            2),
                                                    (3,            3),
                                                    (4,            4),
                                                    (5,            5);
	-- Question 2: lấy ra tất cả các phòng ban
    SELECT DepartmentName FROM `Department`;
												                                  
   -- Question 3: lấy ra id của phòng ban "Sale" (đang bị sai??)
   SELECT DepartmentID  FROM `Department` WHERE DepartmentName = `Sale`;
    
-- Question 4: lấy ra thông tin account có full name dài nhất
SELECT *  FROM `Account` order by length (Fullname) desc;

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id=3
SELECT *  FROM `Account`  WHERE DepartmentID=3 order by length (Fullname) desc;

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT *  FROM `GROUP`  WHERE CreateDate <2019-12-20;


-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT ExamID FROM `Exam` WHERE Duration >= 60 AND  CreateDate < 2019-12-20;
-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT *  FROM `GROUP`  ORDER BY CreateDate DESC LIMIT 5;
-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(*) FROM `Account` WHERE DepartmentID  =2;
-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT * FROM `account` WHERE Fullname LIKE 'D%o';
-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE * FROM Exam WHERE CreateDate < DATE'2019-12-20';
-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE * FROM `Content ` WHERE Content LIKE câu hỏi%;
-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE 'Account' WHERE 'AccountID' = 1
SET Fullname = Nguyễn Bá Lộc, EMAIL  = loc.nguyenba@vti.com.vn;
-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
UPDATE 'Account' WHERE 'AccountID' = 5
SET 'AccountID' = 4;



    
     
    
    
    