-- Question 1: Thêm ít nhất 10 record vào mỗi table.
-- Tạo table với các ràng buộc và kiểu dữ liệu
-- Table 1:Department
--  DepartmentID: định danh của phòng ban (auto increment)
-- DepartmentName: tên đầy đủ của phòng ban (VD: sale, marketing, …)
   -- Tạo database
DROP DATABASE IF EXISTS Testing_System_Assignment_1;
CREATE DATABASE Testing_System_Assignment_1;
USE Testing_System_Assignment_1;
   -- Tạo table 1: Department
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
DepartmentID    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
DepartmentName  VARCHAR(30) NOT NULL UNIQUE KEY
);

-- Table 2: Position
-- PositionID: định danh của chức vụ (auto increment)
-- PositionName: tên chức vụ (Dev, Test, Scrum Master, PM)
DROP TABLE IF EXISTS Position;
CREATE TABLE Position (
PositionID    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
PositionName  ENUM ('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY
);

-- Table 3: Account
-- AccountID: định danh của User (auto increment)
--  Email: 
--  Username: 
--  FullName: 
--  DepartmentID: phòng ban của user trong hệ thống
--  PositionID: chức vụ của User
-- CreateDate: ngày tạo tài khoản

DROP TABLE IF EXISTS Account;
CREATE TABLE Account (
AccountID    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Email        VARCHAR(30) NOT NULL UNIQUE KEY,
Username     VARCHAR(30) NOT NULL UNIQUE KEY,
FullName     VARCHAR(30) NOT NULL,
DepartmentID TINYINT UNSIGNED NOT NULL,
PositionID   TINYINT UNSIGNED NOT NULL,
CreateDate   DATETIME DEFAULT NOW(),
FOREIGN KEY(DepartmentID) REFERENCES  Department(DepartmentID),
FOREIGN KEY(PositionID) REFERENCES  Position (PositionID )
);
-- Table 4: Group
--  GroupID: định danh của nhóm (auto increment)
--  GroupName: tên nhóm
--  CreatorID: id của người tạo group
-- CreateDate: ngày tạo group
  DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
GroupID        TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
GroupName      VARCHAR(30) NOT NULL UNIQUE KEY,
CreatorID      TINYINT UNSIGNED NOT NULL,
CreateDate     DATETIME DEFAULT NOW(),
FOREIGN KEY(CreatorID) REFERENCES  `Account`(AccountID)
);

-- Table 5: GroupAccount
-- GroupID: định danh của nhóm
-- AccountID: định danh của User
-- JoinDate: Ngày user tham gia vào nhóm
 DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE `GroupAccount`(
GroupID        TINYINT UNSIGNED NOT NULL,
AccountID      TINYINT UNSIGNED NOT NULL,
JoinDate      DATETIME DEFAULT NOW(),
PRIMARY KEY(GroupID, AccountID),
FOREIGN KEY(GroupID) REFERENCES  `Group`(GroupID),
FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
);

-- Table 6: TypeQuestion
-- TypeID: định danh của loại câu hỏi (auto increment)
-- TypeName: tên của loại câu hỏi (Essay, Multiple-Choice)
DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE `TypeQuestion`(
TypeID        TINYINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
TypeName      ENUM('Essay', 'Multiple-Choice')  NOT NULL UNIQUE KEY
);

-- Table 7: CategoryQuestion
--  CategoryID: định danh của chủ đề câu hỏi (auto increment)
--  CategoryName: tên của chủ đề câu hỏi (Java, .NET, SQL, Postman, Ruby,...)
DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE `CategoryQuestion`(
CategoryID        TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
CategoryName      VARCHAR(30)  NOT NULL UNIQUE KEY
);
-- Table 8: Question
-- QuestionID: định danh của câu hỏi (auto increment)
--  Content: nội dung của câu hỏi
--  CategoryID: định danh của chủ đề câu hỏi
-- TypeID: định danh của loại câu hỏi
--  CreatorID: id của người tạo câu hỏi
--  CreateDate: ngày tạo câu hỏi
DROP TABLE IF EXISTS `Question`; 
CREATE TABLE `Question` (
	QuestionID                 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content                    VARCHAR(100) NOT NULL,
    CategoryID                 TINYINT UNSIGNED  NOT NULL,
    TypeID                     TINYINT UNSIGNED  NOT NULL,
	CreatorID                  TINYINT UNSIGNED NOT NULL,
    CreateDate                 DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
    FOREIGN KEY(TypeID) REFERENCES `TypeQuestion`(TypeID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID) 
    );
    
-- Table 9: Answer
-- AnswerID: định danh của câu trả lời (auto increment)
-- Content: nội dung của câu trả lời
-- QuestionID: định danh của câu hỏi
-- isCorrect: câu trả lời này đúng hay sai
DROP TABLE IF EXISTS `Answer`; 
CREATE TABLE `Answer` (
	AnswerID                TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content                Varchar(100) NOT NULL ,
    QuestionID            TINYINT UNSIGNED NOT NULL,
    isCorrect              ENUM('Đúng', 'Sai'),
	FOREIGN KEY(QuestionID) REFERENCES `Question`(QuestionID) 
    );   
--  Table 10: Exam
-- ExamID: định danh của đề thi (auto increment)
--  Code: mã đề thi
-- Title: tiêu đề của đề thi
-- CategoryID: định danh của chủ đề thi
--  Duration: thời gian thi
-- CreatorID: id của người tạo đề thi
--  CreateDate: ngày tạo đề thi   
DROP TABLE IF EXISTS `Exam`; 
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
        
-- Table 11: ExamQuestion
-- ExamID: định danh của đề thi
--  QuestionID: định danh của câu hỏi

DROP TABLE IF EXISTS `ExamQuestion`; 
CREATE TABLE `ExamQuestion` (
	ExamID                TINYINT UNSIGNED NOT NULL,
    QuestionID            TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (ExamID, QuestionID),
    FOREIGN KEY(ExamID) REFERENCES `Exam`(ExamID), 
    FOREIGN KEY(QuestionID) REFERENCES `Question`(QuestionID)
    );     
  -- Insert data vào 11 table, mỗi table có ít nhất 10 records     
  -- 1.INSERT INTO Department
  INSERT INTO Department(DepartmentName)
    VALUES                                  ('data1'),
                                            ('data2'),
                                            ('data3'),
                                            ('data4'),
                                            ('data5'),
                                            ('data6'),
                                            ('data7'),
                                            ('data8'),
                                            ('data9'),
                                            ('data10');

	-- 2.INSERT INTO Position
    INSERT INTO `Position`                (PositionName)
	VALUES                                  ('Dev'),
											('Test'),
                                            ('Scrum Master'),
                                            ('PM');									
											
                                        
	-- 3.INSERT INTO `Account`
    INSERT INTO `Account`                    (Email,                 Username,          FullName,          DepartmentID,     PositionID)
    VALUES                                 ('email1@gmail.com',    'username1',        'fullname1',             1,            1),
										   ('email2@gmail.com',    'username2',        'fullname2',             2,            2),
                                           ('email3@gmail.com',    'username3',        'fullname3',             3,            3),
                                           ('email4@gmail.com',    'username4',        'fullname4',             1,            4),
                                           ('email5@gmail.com',    'username5',        'fullname5',             4,            1),
                                            ('email6@gmail.com',    'username6',        'fullname6',             5,           2),
										   ('email7@gmail.com',    'username7',        'fullname7',             7,            4),
                                           ('email8@gmail.com',    'username8',        'fullname8',             6,            3),
                                           ('email9@gmail.com',    'username9',        'fullname9',             10,            4),
                                           ('email10@gmail.com',    'username10',        'fullname10',           9,            1);
    -- 4.INSERT INTO `Group`
    INSERT INTO `Group`                      (GroupName,          CreatorID)
	VALUES 								   ('GroupName1',       1),
   							               ('GroupName2',       2),
   								           ('GroupName3',       3),
   							               ('GroupName4',       4),
                 						   ('GroupName5',       5),
                                           ('GroupName6',       6),
   							               ('GroupName7',       7),
   								           ('GroupName8',       8),
   							               ('GroupName9',       9),
                 						   ('GroupName10',       10);
	-- 5.INSERT INTO 'GroupAccount'
    INSERT INTO GroupAccount                      (GroupID,             AccountID,         JoinDate  )
	VALUES 								            (1,                   1,              '2022-07-20'),
													(2,                   2,              '2022-07-20'),
                                                    (3,                   3,              '2022-07-20'),
                                                    (4,                  4,              '2022-07-20'),
                                                    (5,                  5,              '2022-07-20'),
                                                    (6,                   1,              '2022-07-20'),
													(7,                   2,              '2022-07-20'),
                                                    (8,                   3,              '2022-07-20'),
                                                    (9,                  4,              '2022-07-20'),
                                                    (10,                  5,              '2022-07-20');
                                                    
   				
	-- 6.INSERT INTO TypeQuestion
    INSERT INTO TypeQuestion                       (TypeName )
    VALUES                                          ('Essay'),
                                                    ('Multiple-Choice');
													
    -- 7.INSERT INTO CategoryQuestion
    INSERT INTO CategoryQuestion                   (CategoryName)
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
												   ('Content1',  5,        2,     1,      '2022-07-20');
                                                   
    
	-- 9.INSERT INTO Answer
	INSERT INTO Answer                            (Content,       QuestionID,        isCorrect)
    VALUES                                        ('Content1',     1,              'Đúng'),
												  ('Content2',     2,              'Đúng'),
                                                  ('Content3',     3,              'Sai'),
												  ('Content4',     4,              'Sai'),
												  ('Content5',     5,              'Sai');
    
    -- 10.INSERT INTO Exam
    INSERT INTO Exam                                (Code ,        Title,              CategoryID,     Duration,      CreatorID)
    VALUES                                          (1,          'Title1',            1,           90,            1),
													(2,          'Title2',            2,           90,            2),
                                                    (3,          'Title3',            3,           60,            3),
                                                    (4,          'Title4',            4,           90,            4),
													(3,          'Title5',            5,           120,            5),
                                                    (5,          'Title6',            1,           90,            1),
													(6,          'Title7',            2,           90,            2),
                                                    (7,          'Title8',            3,           60,            3),
                                                    (8,          'Title9',            4,           90,            4),
													(9,          'Title10',            5,           120,            5);
                                                    
       
     -- 11.INSERT INTO  ExamQuestion
     INSERT INTO  ExamQuestion                      (ExamID,        QuestionID) 
     VALUES                                         (1,            1),
                                                    (2,            2),
                                                    (3,            3),
                                                    (4,            4),
                                                    (5,            5),
													(6,            1),
                                                    (7,            2),
                                                    (8,            3),
                                                    (9,            4),
                                                    (10,           5);
  -- Question 2: lấy ra tất cả các phòng ban
  SELECT *FROM Department;
  -- Question 3: lấy ra id của phòng ban "Sale"
  SELECT DepartmentID FROM Department WHERE DepartmentName= 'Sale';
  -- Question 4: lấy ra thông tin account có full name dài nhất
  SELECT * FROM `Account`
  WHERE LENGTH(FullName) = (SELECT MAX(LENGTH(FullName)) FROM `Account`);
 -- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
WITH CTE_depID3 AS
(
SELECT * FROM `Account` WHERE DepartmentID =3
)
SELECT * FROM `CTE_depID3` 
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `CTE_depID3`);
-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT GroupName FROM `Group` WHERE CreateDate < 20/12/2019;
-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT QuestionID, count(1) sl FROM Answer GROUP BY QuestionID 
HAVING COUNT(1) >= 4;
-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
-- Cách 1
WITH cte_table8 AS
(
SELECT * FROM Exam WHERE CreateDate< 20/12/2019
)
SELECT ExamID  FROM cte_table8 WHERE Duration >=60;
-- Cách 2: 
SELECT ExamID FROM `Exam` WHERE Duration >= 60 AND  CreateDate < 2019-12-20;
-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM `Group` ORDER BY (CreateDate) DESC LIMIT 5;
-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(1) FROM `Account` WHERE DepartmentID = 2;
-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT * FROM `Account`;
SELECT FullName FROM `Account` WHERE FullName  LIKE 'D%o';
-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
SELECT * FROM Exam;
DELETE FROM Exam WHERE CreateDate < '2019-12-20';
-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE FROM `Question` WHERE (SUBSTRING_INDEX(Content,' ',2))='câu hỏi';
 SELECT * FROM `Question`;
-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và
-- email thành loc.nguyenba@vti.com.vn
UPDATE 		`Account` SET		Fullname 	= 	'Nguyễn Bá Lộc', 
			                    Email 		= 	'loc.nguyenba@vti.com.vn'
WHERE 		AccountID = 5;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
UPDATE 		`GroupAccount` SET		AccountID    	= 	4
WHERE 		AccountID = 5;
        