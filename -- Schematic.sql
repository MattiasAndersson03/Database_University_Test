-- Institutions
INSERT INTO Institutions (institution_name, abbreviation) VALUES
('Lunds Tekniska Högskola', 'LTH');

-- Programs
INSERT INTO Programs (program_id, program_name, institution_name) VALUES
(1, 'Datavetenskap', 'Lunds Tekniska Högskola'),
(2, 'Teknik', 'Lunds Tekniska Högskola'),
(3, 'Företagsekonomi', 'Lunds Tekniska Högskola');

-- Branches
INSERT INTO Branches (branch_id, branch_name, program_id) VALUES
(101, 'Mjukvaruutveckling', 1),
(201, 'Elektroteknik', 2),
(301, 'Marknadsföring', 3);

-- Courses
INSERT INTO Courses (course_code, course_name, institution_name, credits, classification, max_capacity)
VALUES
('CS101', 'Introduktion till Programmering', 'Lunds Tekniska Högskola', 5, 'Kärna', 100),
('CS102', 'Databassystem', 'Lunds Tekniska Högskola', 5, 'Kärna', 80),
('IT201', 'Informations Teknik', 'Lunds Tekniska Högskola', 6, 'Kärna', 80),
('MKT201', 'Digital Marknadsföring', 'Lunds Tekniska Högskola', 4, 'Kärna', 120),
('MKT201', 'Digital Marknasföring 2', 'Lunds Tekniska Högskola', 3,'Kärna',120),
('PHY101', 'Physics', 'Lunds Tekniska Högskola', 3, 'Valfri', 60),
('ENG101', 'English Composition', 'Lunds Tekniska Högskola', 3, 'Valfri', 90),
('MAT101', 'Matematik1', 'Lunds Tekniska Högskola', 4, 'Kärna', 70),
('PSY101', 'Introdoktion till psykologi', 'Lunds Tekniska Högskola', 3, 'Valfri', 100),
('ART101', 'Konst Historia', 'Lunds Tekniska Högskola', 3, 'Valfri', 80),
('CHEM101', 'Kemi basics', 'Lunds Tekniska Högskola', 4, 'Kärna', 75),
('BIO101', 'Introdoktion till biologi', 'Lunds Tekniska Högskola', 3, 'Valfri', 85),
('HIS101', 'Världs historia', 'Lunds Tekniska Högskola', 4, 'Valfri', 110),
('BUS101', 'Introduktion till företagande', 'Lunds Tekniska Högskola', 3, 'Valfri', 95);

-- Classifications
INSERT INTO Classifications (classification_name) VALUES
('Kärna'),
('Valfri');

-- Students 
INSERT INTO Students (idnr, name, program_id, branch_id, year_of_study) VALUES
(1, 'Johan Persson', 1, 101, 2),
(2, 'Eva Andersson', 2, 201, 1),
(3, 'Anna Nilsson', 3, 301, 3);

-- Registrations 
INSERT INTO Registrations (idnr, course_code, registration_status, grade) VALUES
(1, 'CS101', 'Registrerad', 5),
(2, 'MKT101', 'Registrerad', 5);

-- Mandatory Program Courses 
INSERT INTO Mandatory_Program_Courses (program_id, course_code, classification_name)
VALUES
(1, 'MAT101', 'Kärna'), 
(2, 'MAT101', 'Kärna'),
(3, 'MAT101', 'Kärna'); 

-- Mandatory_Branch_Courses !
INSERT INTO Mandatory_Branch_Courses (branch_id, course_code, classification_name)
VALUES
(101, 'CS101', 'Kärna'),
(101, 'CS102', 'Kärna'), 
(201, 'IT201', 'Kärna'), 
(301, 'MKT201', 'Kärna'),
(301, 'MKT101', 'Kärna'); 

-- Recommended_Branch_Courses 
INSERT INTO Recommended_Branch_Courses (branch_id, course_code, classification_name)
VALUES
(101, 'BUS101', 'Valfri'),
(201, 'CHEM101', 'Valfri'),
(301, 'BIO101', 'Valfri');



