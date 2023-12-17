--Tables

CREATE TABLE Institutions (
    institution_name VARCHAR(50) PRIMARY KEY,
    abbreviation VARCHAR(10)
);

CREATE TABLE Programs (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(50) UNIQUE NOT NULL,
    institution_name VARCHAR(50),
    FOREIGN KEY (institution_name) REFERENCES Institutions(institution_name)
);

CREATE TABLE Branches (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(50) UNIQUE NOT NULL,
    program_id INT,
    FOREIGN KEY (program_id) REFERENCES Programs(program_id)
);
 
CREATE TABLE Courses (
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    institution_name VARCHAR(50),
    credits INT,
    classification VARCHAR(50),
    max_capacity INT,
    FOREIGN KEY (institution_name) REFERENCES Institutions(institution_name)
);

CREATE TABLE Classifications (
    classification_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Students (
    idnr INT PRIMARY KEY,
    name VARCHAR(100),
    program_id INT,
    branch_id INT,
    year_of_study INT,
    FOREIGN KEY (program_id) REFERENCES Programs(program_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

CREATE TABLE Registrations (
    idnr INT,
    course_code VARCHAR(20),
    registration_status VARCHAR(20),
    grade VARCHAR(5),
    FOREIGN KEY (idnr) REFERENCES Students(idnr),
    FOREIGN KEY (course_code) REFERENCES Courses(course_code)
);


CREATE TABLE Mandatory_Program_Courses (
    program_id INT,
    course_code VARCHAR(20),
    classification_name VARCHAR(50),
    PRIMARY KEY (program_id, course_code),
    FOREIGN KEY (program_id) REFERENCES Programs(program_id),
    FOREIGN KEY (course_code) REFERENCES Courses(course_code),
    FOREIGN KEY (classification_name) REFERENCES Classifications(classification_name)
);

CREATE TABLE Mandatory_Branch_Courses (
    branch_id INT,
    course_code VARCHAR(20),
    classification_name VARCHAR(50),
    PRIMARY KEY (branch_id, course_code),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (course_code) REFERENCES Courses(course_code),
    FOREIGN KEY (classification_name) REFERENCES Classifications(classification_name)
);

CREATE TABLE Recommended_Branch_Courses (
    branch_id INT,
    course_code VARCHAR(20),
    classification_name VARCHAR(50),
    PRIMARY KEY (branch_id, course_code),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (course_code) REFERENCES Courses(course_code),
    FOREIGN KEY (classification_name) REFERENCES Classifications(classification_name)
);

-- Studie Adminastratör
CREATE OR REPLACE PROCEDURE register_student_on_course(
    student_id INT,
    course_code VARCHAR(20)
)
AS $$
BEGIN
    INSERT INTO Registrations(idnr, course_code, registration_status)
    VALUES(student_id, course_code, 'Admin Override');
END;
$$ LANGUAGE plpgsql;


CREATE SCHEMA public;
DROP SCHEMA public CASCADE;


