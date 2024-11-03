-- Active: 1729821894241@@127.0.0.1@5432@university_db
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE NOT NULL,
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);

INSERT INTO
    students (
        student_id,
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        1,
        'Sameer',
        21,
        'sameer@example.com',
        48,
        60,
        NULL
    ),
    (
        2,
        'Zoya',
        23,
        'zoya@example.com',
        52,
        58,
        NULL
    ),
    (
        3,
        'Nabil',
        22,
        'nabil@example.com',
        37,
        46,
        NULL
    ),
    (
        4,
        'Rafi',
        24,
        'rafi@example.com',
        41,
        40,
        NULL
    ),
    (
        5,
        'Sophia',
        22,
        'sophia@example.com',
        50,
        52,
        NULL
    ),
    (
        6,
        'Hasan',
        23,
        'hasan@gmail.com',
        43,
        39,
        NULL
    );

SELECT * FROM students;

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

INSERT INTO
    courses (
        course_id,
        course_name,
        credits
    )
VALUES (1, 'Next.js', 3),
    (2, 'React.js', 4),
    (3, 'Databases', 3),
    (4, 'Prisma', 3);

CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT REFERENCES students (student_id),
    course_id INT REFERENCES courses (course_id)
);

INSERT INTO
    enrollment (
        enrollment_id,
        student_id,
        course_id
    )
VALUES (1, 1, 1),
    (2, 1, 2),
    (3, 2, 1),
    (4, 3, 2);

SELECT * FROM enrollment;

-- Query 1:
-- Insert a new student record with the following details:

INSERT INTO
    students (
        student_id,
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        7,
        'Shohaib',
        28,
        'khanshohaibhossain@gmail.com',
        50,
        55,
        NULL
    );

-- Query 2:
-- Retrieve the names of all students who are enrolled in the course titled 'Next.js'.

SELECT student_name
FROM students
WHERE
    student_id IN (
        SELECT student_id
        FROM enrollment
        WHERE
            course_id = (
                SELECT course_id
                FROM courses
                WHERE
                    course_name = 'Next.js'
            )
    );

-- Query 3:
-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.

UPDATE students SET status = 'Awarded'
    WHERE student_id = (
        SELECT student_id FROM students
            ORDER BY (frontend_mark + backend_mark) DESC
            LIMIT 1
    );


-- Query 4:
-- Delete all courses that have no students enrolled.

SELECT * FROM courses;

SELECT * FROM enrollment;

DELETE FROM courses
    WHERE course_id NOT IN (
        SELECT DISTINCT course_id FROM enrollment
    );

-- Query 5:
-- Retrieve the names of students using a limit of 2, starting from the 3rd student.

SELECT student_name from students
    ORDER BY student_id
    LIMIT 2 OFFSET 2;

-- Query 6:
-- Retrieve the course names and the number of students enrolled in each course.

SELECT * FROM courses;
SELECT * FROM enrollment;

SELECT course_name ,count(enrollment.student_id) AS studnet_count from courses
    LEFT JOIN enrollment ON courses.course_id = enrollment.course_id
    GROUP BY courses.course_name;

-- Query 7:
-- Calculate and display the average age of all students.

SELECT AVG(age) AS average_age FROM students;

-- Query 8:
-- Retrieve the names of students whose email addresses contain 'example.com'.

SELECT student_name FROM students
    WHERE email LIKE '%example.com';