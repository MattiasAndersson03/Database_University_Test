-- Views

 -- basic_information Klar
CREATE VIEW basic_information AS
SELECT S.idnr, S.name, P.program_name AS program, B.branch_name
FROM Students S
LEFT JOIN Programs P ON S.program_id = P.program_id
LEFT JOIN Branches B ON S.branch_id = B.branch_id;
-- Denna vy ger grundläggande information om studenter, inklusive deras ID, namn, programnamn 
-- och namn på den gren de är anslutna till. Det sammanför information från Students-tabellen och relaterade kolumner i Programs och 
-- Branches-tabellerna genom JOIN-operationer.

-- finished_courses Klar
CREATE VIEW finished_courses AS
SELECT Students.idnr AS student_id,
       Students.name AS student_name,
       Courses.course_name AS course_name,
       Registrations.grade AS grade,
       Courses.credits AS credits
FROM Students
JOIN Registrations ON Students.idnr = Registrations.idnr
JOIN Courses ON Registrations.course_code = Courses.course_code
WHERE Registrations.grade IS NOT NULL;
-- Denhär vyn listar kurser som studenter har slutfört. Den visar student-ID, studentnamn, 
--kursnamn, betyg och antal poäng för de kurser där studenterna har ett betyg som inte är NULL. Den använder 
--JOIN-operationer mellan Students, Registrations och Courses-tabellerna.

-- passed_courses Klar
CREATE VIEW passed_courses AS
SELECT s.idnr AS student_id, s.name AS student_name, c.course_code, c.course_name, r.grade
FROM Students s
JOIN Registrations r ON s.idnr = r.idnr
JOIN Courses c ON r.course_code = c.course_code
WHERE r.grade IN ('A', 'B', 'C', 'D', 'E');
-- Denna vy liknar "finished_courses", men den visar enbart kurser där studenterna har klarat kursen. 
-- Den filtrerar efter betyg (A, B, C, D eller E) och visar student-ID, studentnamn, kurskod, kursnamn och betyg för kurser 
--där studenten har klarat kursen.

-- registrations Klar
CREATE VIEW registrationsview AS
SELECT s.idnr AS student_id, s.name AS student_name, c.course_code, c.course_name
FROM Students s
JOIN Registrations r ON s.idnr = r.idnr
JOIN Courses c ON r.course_code = c.course_code
WHERE r.grade IS NULL;
--Denna vy listar studenter som är registrerade för kurser där betyget ännu inte är satt (NULL). 
--Den visar student-ID, studentnamn, kurskod och kursnamn från Students, Registrations och Courses-tabellerna.

-- unread_mandatory ej klar
CREATE VIEW unread_mandatory AS
SELECT student, course
FROM (
    SELECT s.idnr AS student, mc.course_code AS course
    FROM Students s
    LEFT JOIN (
        SELECT s.idnr, mc.course_code
        FROM Students s
        JOIN Mandatory_Program_Courses mc ON s.program_id = mc.program_id
        WHERE mc.course_code NOT IN (
            SELECT course_code
            FROM Registrations r
            WHERE r.idnr = s.idnr
        )
    ) mc ON s.idnr = mc.idnr

    UNION

    SELECT s.idnr AS student, bc.course_code AS course
    FROM Students s
    LEFT JOIN (
        SELECT s.idnr, bc.course_code
        FROM Students s
        JOIN Branches b ON s.branch_id = b.branch_id
        JOIN Mandatory_Branch_Courses bc ON b.branch_id = bc.branch_id
        WHERE bc.course_code NOT IN (
            SELECT course_code
            FROM Registrations r
            WHERE r.idnr = s.idnr
        )
    ) bc ON s.idnr = bc.idnr
) AS combined_courses
WHERE course IS NOT NULL;
-- Denna vy är avsedd att lista de obligatoriska kurser som en student ännu inte har läst. 
--Den kombinerar de obligatoriska kurserna för studentens program och gren och identifierar de kurser som inte redan är registrerade av studenten. 
--Den visar student-ID, studentnamn och kurskod för dessa olästa obligatoriska kurser.


