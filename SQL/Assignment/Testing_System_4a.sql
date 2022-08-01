-- Question 1: 
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
  -- Insert data vào 11 table, mỗi table có ít nhất 5 records     
  -- 1.INSERT INTO Department
  INSERT INTO Department(DepartmentName)
    VALUES                                  ('data1'),
                                            ('data2'),
                                            ('data3'),
                                            ('data4'),
                                            ('data5');

	-- 2.INSERT INTO Position
    INSERT INTO `Position`                (PositionName)
	VALUES                                  ('Dev'),
											('Test'),
                                            ('Scrum Master'),
                                            ('PM');									
											
                                        
	-- 3.INSERT INTO `Account`
    INSERT INTO `Account`                    (Email,                 Username,          FullName,          DepartmentID,     PositionID)
    VALUES                                 ('email1@gmail.com',    'username1',        'fullname1',             1,            2),
										   ('email2@gmail.com',    'username2',        'fullname2',             2,            1),
                                           ('email3@gmail.com',    'username3',        'fullname3',             3,            4),
                                           ('email4@gmail.com',    'username4',        'fullname4',             1,            1),
                                           ('email5@gmail.com',    'username5',        'fullname5',             4,            1);
    -- 4.INSERT INTO `Group`
    INSERT INTO `Group`                      (GroupName,          CreatorID)
	VALUES 								   ('GroupName1',       1),
   							               ('GroupName2',       1),
   								           ('GroupName3',       1),
   							               ('GroupName4',       1),
                 						   ('GroupName5',       1);
	-- 5.INSERT INTO 'GroupAccount'
    INSERT INTO GroupAccount                      (GroupID,             AccountID,         JoinDate  )
	VALUES 								            (1,                   1,              '2022-07-20'),
													(2,                   2,              '2022-07-20'),
                                                    (3,                   3,              '2022-07-20'),
                                                    (2,                  4,              '2022-07-20'),
                                                    (4,                  5,              '2022-07-20');
                                                    
   				
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
                                                   ('CategoryName5');
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
												  ('Content2',     1,              'Đúng'),
                                                  ('Content3',     1,              'Sai'),
												  ('Content4',     1,              'Sai'),
												  ('Content5',     1,              'Sai');
                                                  
    
    -- 10.INSERT INTO Exam
    INSERT INTO Exam                                (Code ,        Title,              CategoryID,     Duration,      CreatorID)
    VALUES                                          (1,          'Title1',            1,           90,            1),
													(2,          'Title2',            2,           90,            2),
                                                    (3,          'Title3',            3,           60,            3),
                                                    (4,          'Title4',            4,           90,            4),
													(3,          'Title5',            5,           120,            5);
                                                    
       
     -- 11.INSERT INTO  ExamQuestion
     INSERT INTO  ExamQuestion                      (ExamID,        QuestionID) 
     VALUES                                         (1,            1),
                                                    (2,            2),
                                                    (3,            3),
                                                    (4,            4),
                                                    (5,            5);
    --  Exercise 1: Join
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT * FROM `account`;
SELECT * FROM Department;
SELECT * FROM account a
INNER JOIN Department d
ON a.DepartmentID=d.DepartmentID;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT * FROM `account`
WHERE 'CreateDate' > '20/12/2010';

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT * FROM `account` a
INNER JOIN Posittion p
ON a.PositionID  = p.PositionID
WHERE PositionName = 'Dev';
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
 SELECT count(1) SL, d.DepartmentName, a.DepartmentID from `Account` a
    INNER JOIN `Department` d ON a.DepartmentID = d.DepartmentID
    Group by DepartmentID 
    having count(1)>3;
-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều
-- nhất
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
-- 1.Group by CategoryID
-- 2.Đếm count  CategoryID
SElECT COUNT(q.CategoryID), q.CategoryID, cq.CategoryName   FROM question q 
INNER JOIN CategoryQuestion  cq ON   cq.CategoryID=q.CategoryID
GROUP BY CategoryID;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam


-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
-- Question 9: Thống kê số lượng account trong mỗi group
SELECT		g.  GroupName, COUNT(ga.AccountID) 
FROM		GroupAccount GA 
INNER JOIN 	 `Group` g 
ON	ga.GroupID = g.GroupID
GROUP BY	G.GroupID;

-- Question 10: Tìm chức vụ có ít người nhất
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT d.DepartmentID,d.DepartmentName, p.PositionName, count(p.PositionName) FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
INNER JOIN position p ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID;


-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT q.QuestionID,t.TypeName, q.Content AS nộidungcâuhỏi, a.Content AS  trảlời, q.CreatorID FROM Question q
INNER JOIN Answer a
ON q.QuestionID = a.QuestionID
INNER JOIN TypeQuestion t
ON q.TypeID = t.TypeID;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT COUNT(q.TypeID), tq.TypeName, tq.TypeID FROM Question q
INNER JOIN TypeQuestion tq
ON q.TypeID = tq.TypeID
GROUP BY TypeID;
-- Question 14:Lấy ra group không có account nào
SELECT * FROM `Group` g
LEFT JOIN GroupAccount ga ON g.GroupID = ga.GroupID
WHERE GA.AccountID IS NULL;

-- Question 15: Lấy ra group không có account nào
-- GIỐNG 14

-- Question 16: Lấy ra question không có answer nào
SELECT q.QuestionID, q.Content     FROM Question q
LEFT JOIN Answer a 
ON q.QuestionID = a.QuestionID 
WHERE a.AnswerID IS NULL;

-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
SELECT a.FullName  FROM `Account` a
JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 1;

-- b) Lấy các account thuộc nhóm thứ 2
SELECT a.FullName  FROM `Account` a
JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 2;
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT a.FullName  FROM `Account` a
JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 1
UNION DISTINCT
SELECT a.FullName  FROM `Account` a
JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 2;
-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
SELECT 		g.GroupName, COUNT(ga.GroupID) FROM  GroupAccount ga
INNER JOIN 	`Group` g 
ON ga.GroupID = g.GroupID
GROUP BY	g.GroupID
HAVING 		COUNT(ga.GroupID) >5;
-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT 		g.GroupName, COUNT(ga.GroupID) FROM  GroupAccount ga
JOIN 		`Group` g ON ga.GroupID = g.GroupID
GROUP BY	g.GroupID
HAVING 		COUNT(ga.GroupID) <7;
-- c) Ghép 2 kết quả từ câu a) và câu b)                                                
  SELECT 		g.GroupName, COUNT(ga.GroupID) FROM  GroupAccount ga
INNER JOIN 	`Group` g 
ON ga.GroupID = g.GroupID
GROUP BY	g.GroupID
HAVING 		COUNT(ga.GroupID) >5
UNION
SELECT 		g.GroupName, COUNT(ga.GroupID) FROM  GroupAccount ga
JOIN 		`Group` g ON ga.GroupID = g.GroupID
GROUP BY	g.GroupID
HAVING 		COUNT(ga.GroupID) <7;
        