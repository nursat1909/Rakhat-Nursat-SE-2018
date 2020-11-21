CREATE TABLE student (
student_id INT PRIMARY KEY, 
student_name VARCHAR(32),
student_surname VARCHAR(32),
stud_gender VARCHAR(6),
stud_phone_number Decimal(12),
stud_birthday DATE,
city VARCHAR(32) 
);                                      --We've created this table for all information about student, students are participants of courses and meetings 
                                        --they will groupping into groups which is piece of faculty
CREATE TABLE teacher (
teacher_id INT PRIMARY KEY,
teacher_name VARCHAR(32),
teacher_surname VARCHAR(32),
gender VARCHAR(6),
birthday DATE
);                                      --This table is teachers' information, teacher have to lead courses and meetings they don't have groupping. Just teachers

CREATE TABLE group_ (
group_name VARCHAR(32) PRIMARY KEY,
head VARCHAR(32),          
student_id INT,                                  --Group is set of students that study together in same faculty. They are about 10-20, up to faculty.
FOREIGN KEY(student_id) REFERENCES student(student_id)   --In group we have only students.
);

                                       
CREATE TABLE course (
course_name VARCHAR(32) PRIMARY KEY,
course_day VARCHAR(32),                  --Course doesn't depend on faculty, one or more faculties may have one course. To course participate teachers and students.
course_time VARCHAR(5),                  --Teachers participate as leaders. 
teacher_id INT,                  
group_name VARCHAR(32),                  
FOREIGN KEY(teacher_id) REFERENCES teacher(teacher_id),
FOREIGN KEY (group_name)REFERENCES group_(group_name)
);                                                 

CREATE TABLE faculty (
faculty_id INT,
faculty_name VARCHAR(32) PRIMARY KEY,    --It is first sorting of students to some directions. In faculty we have groups. And in groups we have students.
group_name VARCHAR(32),
FOREIGN KEY (group_name)REFERENCES group_(group_name)
);                                   


ALTER TABLE faculty DROP CONSTRAINT faculty_pkey;                         --We've created PRIMARY KEY to wrong column, therefore deleting the constraint
ALTER TABLE faculty ADD CONSTRAINT faculty_pkey PRIMARY KEY (faculty_id); --And adding to correct one


CREATE TABLE auditory (
campus_name VARCHAR(32),
auditory_number INT,
floor Decimal (2),
course_name VARCHAR(32),
FOREIGN KEY (course_name)REFERENCES course(course_name),
FOREIGN KEY (campus_name)REFERENCES campus(campus_name),
PRIMARY KEY (auditory_number, campus_name)
);                                                                 --Auditories are rooms in campuses, that courses will be in.
                                                                   --Number of auditories may be same, therefore adding campus name to PRIMARY KEY.
CREATE TABLE club (
club_name VARCHAR(32) PRIMARY KEY,
descripton TEXT,
leader INT,
student_id INT,
FOREIGN KEY (student_id) REFERENCES student(student_id)
FOREIGN KEY (leader) REFERENCES student(student_id)
);                                                                 --Clubs are group of students that created to improove hobbies.
                                                                   --Leader of the clubs are students, that's why we are making 2 foreign keys to same PK.
CREATE TABLE campus (                                              
campus_name VARCHAR(32) PRIMARY KEY,                
location TEXT                                            --Campus is set of auditories that located in one building.  
);

ALTER TABLE campus ALTER COLUMN location SET DATA TYPE VARCHAR(32);  --We've created incorrect data type to location, and changing it to VARCHAR.

CREATE TABLE meeting (
meeting_date DATE,
meeting_time VARCHAR(5),
meeting_place VARCHAR(32),
group_name VARCHAR(32),
PRIMARY KEY(meeting_date, meeting_time, meeting_place),               --Meetings are optional, they not always will be. And meetings haven't id or names. 
FOREIGN KEY(group_name) REFERENCES group_(group_name)                 --We differentiate them by their day, time and place. 
);                    

CREATE TABLE platonus(
login VARCHAR(32) PRIMARY KEY,
password varchar(64),                                                --Platonus is a site that teachers mark and students will see their grades. 
student_id INT,
course_name VARCHAR(32),                                           
FOREIGN KEY (student_id) REFERENCES student(student_id),
FOREIGN KEY (course_name) REFERENCES course(course_name)
);

ALTER TABLE platonus DROP COLUMN password;             --We've added incorrect column password, therefore deleting the column.
ALTER TABLE platonus ADD COLUMN grades Decimal(5);     --and adding correct column