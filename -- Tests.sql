-- Test för två grenar med samma namn på olika program
INSERT INTO Institutions (institution_name, abbreviation) VALUES ('Institution A', 'InstA');
INSERT INTO Programs (program_name, institution_name) VALUES ('Program X', 'Institution A');
INSERT INTO Programs (program_name, institution_name) VALUES ('Program Y', 'Institution A');
INSERT INTO Branches (branch_name, program_id) VALUES ('Branch 1', 1);
INSERT INTO Branches (branch_name, program_id) VALUES ('Branch 1', 2);

-- Test för en student utan kurser
INSERT INTO Students (idnr, name, program_id, branch_id, year_of_study) VALUES (1, 'Student A', 1, 1, 1); 

-- Test för en student med endast underkända kurser
INSERT INTO Registrations (idnr, course_code, registration_status, grade) VALUES (1, 'C001', 'Registered', 'E'); 
INSERT INTO Registrations (idnr, course_code, registration_status, grade) VALUES (1, 'C002', 'Registered', 'E'); 

-- Test för en student utan vald gren
INSERT INTO Students (idnr, name, program_id, year_of_study) VALUES (2, 'Student B', 1, 1); 



