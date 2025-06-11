-- Set time zone
SET TIME ZONE '+07:00';

-- Create database if not exists (manual for PostgreSQL)
-- In Docker, you can create it in the init script
CREATE DATABASE rcu_prod;
\c rcu_prod;

-- ENUM replacements
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'gender_type') THEN
        CREATE TYPE gender_type AS ENUM ('ชาย', 'หญิง');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'parcel_type') THEN
        CREATE TYPE gender_type AS ENUM ('จดหมาย', 'พัสดุ');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'parcel_state') THEN
        CREATE TYPE gender_type AS ENUM ('รอรับ', 'รับแล้ว');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'contact_type') THEN
        CREATE TYPE contact_type AS ENUM ('PHONE', 'EMAIL');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'student_type') THEN
        CREATE TYPE student_type AS ENUM ('ปริญญาตรี', 'ปริญญาโท', 'ปริญญาเอก');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'building_type') THEN
        CREATE TYPE building_type AS ENUM ('รายเทอม', 'รายเดือน');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'attendance_status') THEN
        CREATE TYPE attendance_status AS ENUM ('PRESENT', 'ABSENT', 'LATE');
    END IF;
END
$$;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tables
CREATE TABLE card_color (
    id SERIAL PRIMARY KEY,
    year INT NOT NULL,
    color VARCHAR(9) NOT NULL
);

CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    password CHAR(60) NOT NULL,
    prev_access TIMESTAMP DEFAULT NULL,
    last_access TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    prev_ip VARCHAR(15) DEFAULT NULL,
    last_ip VARCHAR(15) DEFAULT NULL,
    profile VARCHAR(255),
    eng_first_name VARCHAR(50),
    eng_middle_name VARCHAR(50),
    eng_last_name VARCHAR(50),
    th_first_name VARCHAR(50),
    th_middle_name VARCHAR(50),
    th_last_name VARCHAR(50),
    nickname VARCHAR(30),
    gender gender_type NOT NULL,
    birthdate DATE NOT NULL,
    religion VARCHAR(50) NOT NULL,
    blood_type VARCHAR(2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reset_pin (
    ref_code UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id INT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    pin CHAR(6) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "parcel" (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    parcel_number VARCHAR(255) NOT NULL,
    type parcel_type NOT NULL,
    state parcel_state NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE contact (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    content VARCHAR(100) NOT NULL,
    type contact_type NOT NULL
);

CREATE TABLE medical (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    disease JSONB DEFAULT NULL,
    drug JSONB DEFAULT NULL,
    doctor VARCHAR(120),
    hospital VARCHAR(200)
);

CREATE TABLE faculty (
    id CHAR(2) PRIMARY KEY,
    th_name VARCHAR(100) NOT NULL,
    eng_name VARCHAR(100) NOT NULL
);

CREATE TABLE branch (
    id CHAR(4) PRIMARY KEY,
    faculty_id CHAR(2) NOT NULL REFERENCES "faculty"(id) ON DELETE CASCADE,
    th_name VARCHAR(100) NOT NULL,
    eng_name VARCHAR(100) NOT NULL
);

CREATE TABLE program (
    id CHAR(5) PRIMARY KEY,
    branch_id CHAR(4) NOT NULL REFERENCES "branch"(id) ON DELETE CASCADE,
    th_name VARCHAR(100) NOT NULL,
    eng_name VARCHAR(100) NOT NULL
);

CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    chula_id CHAR(10) UNIQUE,
    is_resign BOOLEAN NOT NULL DEFAULT FALSE,
    faculty_id INT NOT NULL REFERENCES faculty(id),
    branch_id INT NOT NULL REFERENCES branch(id),
    program_id INT NOT NULL REFERENCES program(id),
    type student_type NOT NULL
);

CREATE TABLE student_skill (
    id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES student(id),
    skill VARCHAR(100) NOT NULL
);

CREATE TABLE building (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    type building_type DEFAULT 'รายเดือน',
    price FLOAT NOT NULL,
    electric_unit FLOAT NOT NULL,
    water_unit FLOAT NOT NULL
);

CREATE TABLE wing (
    id SERIAL PRIMARY KEY,
    room_start INT NOT NULL,
    room_end INT NOT NULL,
    building_id INT NOT NULL REFERENCES building(id)
);

CREATE TABLE wing_representator (
    id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES student(id),
    wing_id INT NOT NULL REFERENCES wing(id),
    start TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "end" TIMESTAMP DEFAULT NULL,
    year INT NOT NULL
);

CREATE TABLE floor (
    id SERIAL PRIMARY KEY,
    level INT NOT NULL,
    building_id INT NOT NULL REFERENCES building(id)
);

CREATE TABLE room (
    id SERIAL PRIMARY KEY,
    number INT,
    floor_id INT NOT NULL REFERENCES floor(id)
);

CREATE TABLE bed (
    id SERIAL PRIMARY KEY,
    code CHAR(1) NOT NULL,
    room_id INT NOT NULL REFERENCES room(id),
    floor_id INT NOT NULL REFERENCES floor(id)
);

CREATE TABLE activity (
    id SERIAL PRIMARY KEY,
    name VARCHAR(300) NOT NULL,
    date TIMESTAMP DEFAULT NULL,
    score INT DEFAULT 0,
    year INT NOT NULL,
    for_first_year BOOLEAN DEFAULT FALSE,
    head_student BOOLEAN DEFAULT FALSE
);

CREATE TABLE activity_attendance (
    id SERIAL PRIMARY KEY,
    activity_id INT NOT NULL REFERENCES activity(id),
    user_id INT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    status attendance_status NOT NULL DEFAULT 'PRESENT'
);







INSERT INTO institutes (id, name_th, name_en) VALUES
('01', 'สถาบันภาษาไทยสิรินธร', 'THE SIRINDHORN THAI LANGUAGE INSTITUTE'),
('02', 'ศูนย์การศึกษาทั่วไป', 'OFFICE OF ACADEMIC AFFAIRS'),
('20', 'บัณฑิตวิทยาลัย', 'GRADUATE SCHOOL'),
('21', 'คณะวิศวกรรมศาสตร์', 'FACULTY OF ENGINEERING'),
('22', 'คณะอักษรศาสตร์', 'FACULTY OF ARTS'),
('23', 'คณะวิทยาศาสตร์', 'FACULTY OF SCIENCE'),
('24', 'คณะรัฐศาสตร์', 'FACULTY OF POLITICAL SCIENCE'),
('25', 'คณะสถาปัตยกรรมศาสตร์', 'FACULTY OF ARCHITECTURE'),
('26', 'คณะพาณิชยศาสตร์และการบัญชี', 'FACULTY OF COMMERCE AND ACCOUNTANCY'),
('27', 'คณะครุศาสตร์', 'FACULTY OF EDUCATION'),
('28', 'คณะนิเทศศาสตร์', 'FACULTY OF COMMUNICATION ARTS'),
('29', 'คณะเศรษฐศาสตร์', 'FACULTY OF ECONOMICS'),
('30', 'คณะแพทยศาสตร์', 'FACULTY OF MEDICINE'),
('31', 'คณะสัตวแพทยศาสตร์', 'FACULTY OF VETERINARY SCIENCE'),
('32', 'คณะทันตแพทยศาสตร์', 'FACULTY OF DENTISTRY'),
('33', 'คณะเภสัชศาสตร์', 'FACULTY OF PHARMACEUTICAL SCIENCES'),
('34', 'คณะนิติศาสตร์', 'FACULTY OF LAW'),
('35', 'คณะศิลปกรรมศาสตร์', 'FACULTY OF FINE AND APPLIED ARTS'),
('36', 'คณะพยาบาลศาสตร์', 'FACULTY OF NURSING'),
('37', 'คณะสหเวชศาสตร์', 'FACULTY OF ALLIED HEALTH SCIENCES'),
('38', 'คณะจิตวิทยา', 'FACULTY OF PSYCHOLOGY'),
('39', 'คณะวิทยาศาสตร์การกีฬา', 'FACULTY OF SPORTS SCIENCE'),
('40', 'สำนักวิชาทรัพยากรการเกษตร', 'SCHOOL OF AGRICULTURAL RESOURCES'),
('51', 'วิทยาลัยประชากรศาสตร์', 'COLLEGE OF POPULATION STUDIES'),
('53', 'วิทยาลัยวิทยาศาสตร์สาธารณสุข', 'COLLEGE OF PUBLIC HEALTH SCIENCES'),
('55', 'สถาบันภาษา', 'LANGUAGE INSTITUTE'),
('56', 'สถาบันนวัตกรรมบูรณาการ', 'SCHOOL OF INTEGRATED INNOVATION'),
('58', 'สถาบันบัณฑิตบริหารธุรกิจ ศศินทร์ฯ', 'SASIN GRADUATE INSTITUTE OF BUSINESS ADMINISTION'),
('99', 'มหาวิทยาลัยอื่น', 'OTHER UNIVERSITY');


INSERT INTO branch (id, faculty_id, th_name, eng_name) VALUES
('2301', '23', 'ภาควิชาคณิตศาสตร์และวิทยาการคอมพิวเตอร์', 'DEPARTMENT OF MATHEMATICS AND COMPUTER SCIENCE');