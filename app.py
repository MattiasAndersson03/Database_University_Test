from flask import Flask, render_template, jsonify, request
from psycopg2 import connect, DatabaseError

app = Flask(__name__)


#Kopplar sig till databasen när man kör koden
@app.route("/", methods=["GET"]) 
def render_index():
    return render_template("index.html")  

def execute_query(query, parameters=None):
    conn = None
    try:
        conn = connect(
            dbname="postgres",
            user="postgres",
            host="localhost",
            password="9603",
        )
        with conn.cursor() as cursor: 
            cursor.execute(query, parameters) 
            conn.commit() 
            if cursor.description: 
                return cursor.fetchall() 
    
    except DatabaseError as e:
        print(e)
    finally:
        if conn:
            conn.close()

def has_invalid_grade(student_id):
    query = "SELECT grade FROM Registrations WHERE idnr = %s AND (grade = 'U' OR grade IS NULL)"
    result = execute_query(query, (student_id,))
    return bool(result)

@app.route('/register_course', methods=['POST'])
def register_course():
    if request.method == 'POST':
        data = request.get_json()
        student_id = int(data.get('studentId'))
        course_code = data.get('courseCode')

        # Kontrollera om studenten redan är registrerad för kursen
        check_registration_query = "SELECT * FROM Registrations WHERE idnr = %s AND course_code = %s"
        registration_exists = execute_query(check_registration_query, (student_id, course_code))

        if registration_exists:
            return jsonify({'message': 'Failure - Student is already registered for this course'}), 400

        # Kontrollera om studenten redan har betyget U eller NULL i en kurs som där räknas som icke godkänt gör att man inte kan registrera sig på fler kurser
        if has_invalid_grade(student_id):
            return jsonify({'message': 'Failure - Student has "U" or NULL grade, cannot register for more courses'}), 400

        # Kontrollera om studenten och kursen existerar
        query_student = "SELECT * FROM Students WHERE idnr = %s"
        query_course = "SELECT * FROM Courses WHERE course_code = %s"

        student_exists = execute_query(query_student, (student_id,))
        course_exists = execute_query(query_course, (course_code,))

        if student_exists and course_exists:
            
            insert_query = "INSERT INTO Registrations (idnr, course_code, registration_status, grade) VALUES (%s, %s, 'Registered', NULL)"
            execute_query(insert_query, (student_id, course_code))

            return jsonify({'message': 'Success - Student registered for the course'}), 200
        elif not student_exists:
            return jsonify({'message': 'Failure - Student does not exist'}), 400
        elif not course_exists:
            return jsonify({'message': 'Failure - Course does not exist'}), 400
    else:
        return "This endpoint only accepts POST requests.", 405

if __name__ == '__main__':
    app.run(debug=True)