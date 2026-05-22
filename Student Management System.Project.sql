create table students(
students_id int primary key ,
name varchar(50) not null,
gender varchar(40) not null,
dob date not null,
phone varchar(15) not null,
email varchar(50) not null,
address varchar(60) not null,
course_id int
);

create table teacher(
teacher_id int primary key,
name varchar(50) not null,
subject varchar(60) not null,
phone varchar(50) not null,
email varchar(60)
);

create table courses(
course_id int primary key,
course_name varchar(100) not null,
duration varchar(50),
fees decimal(10,2)
);

create table subjects(
subject_id int primary key,
subject_name varchar(50),
course_id int,
teacher_id int,
foreign key(course_id) references course(course_id),
foreign key(teacher_id) references teachers(teacher_id)
);

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    students_id INT,
    subject_id INT,
    date DATE,
    status VARCHAR(10),
    FOREIGN KEY (students_id) REFERENCES students(students_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

CREATE TABLE Marks (
    mark_id INT PRIMARY KEY,
    students_id INT,
    subject_id INT,
    marks INT,
    exam_type VARCHAR(50),
    FOREIGN KEY (students_id) REFERENCES Students(students_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

CREATE TABLE Fees (
    fee_id INT PRIMARY KEY,
    students_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (students_id) REFERENCES Students(students_id)
);

CREATE TABLE Admin (
    admin_id INT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(100)
);

insert into students(students_id,name,gender,dob,phone,email,address,course_id)
values(401,'Sagar singh','Male','2003-08-18','1234567898','sagarsingh338@gmail.com','Kandivali',1),
(402,'Nishitaa Singh','Female','2006-08-18','1239877898','nitu338@gmail.com','Bhayander',2),
(403,'Mayuresh','Male','2005-07-18','9534567898','Mkuveshkar267@gmail.com','Andheri',3),
(404,'Sudhanshu','Male','2007-07-14','9619654690','sgond67@gmail.com','Andheri',4),
(405,'Rajan','Male','2006-03-25','6787654356','gk123@gmail.com','Borivali',5),
(406,'Mayuresh','Male','2003-07-20','9876543212','omkar567@gmail.com','Kandivali',6);

select * from students;

insert into teacher(teacher_id,name,subject,phone,email)
values(201,'Swati Singh','Advanced Sql','9578776534','swati556@gamil.com'),
(202,'Danashree','DSA','1946776534','dan123@gamil.com'),
(203,'Omkar singh','c++ with oop','2346896543','omkar321@gamil.com'),
(204,'Om Patel','Python','5643235567','om67@gamil.com'),
(205,'Shifa','Advanced R','9823567854','shifa116@gamil.com'),
(206,'Santosh Singh','Tools','9151413121','santosh23@gmail.com');
select * from teacher;

insert into courses(course_id,course_name,duration,fees)
values(1,'Data analyst','1 year',120000),
(2,'Data science','3 years',210000),
(3,'Machine learning','2 years',115000),
(4,'AIMl','3 years',408000),
(5,'IT','3 years',310000),
(6,'CS','2 years',120000);
select * from courses;

insert into subjects(subject_id,subject_name,course_id,teacher_id)
values(7,'python',1,201),
(8,'Sql',2,202),
(9,'Machine learning',3,203),
(10,'C++',4,204),
(11,'Advanced R',5,205),
(12,'DSA',6,206);
select * from subjects;

insert into attendance(attendance_id,students_id,subject_id,date,status)
values(301,401,7,'2026-06-15','Present'),
(302,402,8,'2026-06-15','Present'),
(303,403,9,'2026-06-19','Present'),
(304,404,10,'2026-06-15','Present'),
(305,405,11,'2026-06-15','Absent'),
(306,406,7,'2026-06-17','Absent');
select * from attendance;

insert into Marks(mark_id,students_id,subject_id,marks,exam_type)
values(101,401,7,67,'Assignment'),
(102,402,8,87,'Final exam'),
(103,403,9,97,'Mid exam'),
(104,404,10,90,'Assignment'),
(105,405,11,87,'Final exam'),
(106,406,12,91,'Mid exam');
select * from Marks;

INSERT INTO Fees(fee_id, students_id, amount, payment_date, status)
VALUES
(1, 401, 25000.00, '2026-06-10', 'Paid'),
(2, 402, 25000.00, '2026-06-12', 'Pending'),
(3, 403, 30000.00, '2026-06-15', 'Paid'),
(4, 404, 40000.00, '2026-06-13', 'Paid'),
(5, 405, 35000.00, '2026-06-14', 'Paid'),
(6, 406, 30000.00, '2026-06-15', 'Paid');
select * from Fees;

INSERT INTO Admin(admin_id, username, password)
VALUES
(1, 'sudhanshu', 'admin123'),
(2, 'sejal', 'sejal@123'),
(3, 'rajan', 'rajan@123'),
(4, 'omkar', 'omkar@183'),
(5, 'mayur', 'mayur@143'),
(6, 'nishitaa', 'nitu@133');
select * from Admin;

select s.name, c.course_name
from students s
join courses c
on s.course_id = c.course_id;

select s.name, sub.subject_name, a.status, a.date
from attendance a
join students s
on a.students_id = s.students_id
join subjects sub
on a.subject_id = sub.subject_id;

select s.name, sub.subject_name, m.marks, m.exam_type
from marks m
join students s
on m.students_id = s.students_id
join subjects sub
on m.subject_id = sub.subject_id;

select s.name, f.amount, f.status
from fees f
join students s
on f.students_id = s.students_id;

select sum(amount) as Total_Fees
from fees
where status='Paid';