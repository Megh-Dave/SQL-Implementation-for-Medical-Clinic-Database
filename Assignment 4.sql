/* Assignment 4: SQL Implementation - Megh Dave (cc3118) */

/* Q1 */
/* Create a database */
CREATE DATABASE patients;

/* Make patient database as active database */
USE patients;

/* Create a department table */
CREATE TABLE department_T
(department_id int(11) AUTO_INCREMENT NOT NULL,
department_name varchar(25) NOT NULL,
department_location varchar(25),
CONSTRAINT department_pk PRIMARY KEY(department_id));

/* Create a doctor table */
CREATE TABLE doctor_T
(doctor_id int(11) AUTO_INCREMENT NOT NULL,
doctor__name varchar(25) NOT NULL,
qualification varchar(25),
phone_number varchar(25),
doctor_type varchar(10) NOT NULL,
department_id int(11) NOT NULL,
CONSTRAINT doctor_pk PRIMARY KEY(doctor_id),
CONSTRAINT doctor_fk FOREIGN KEY(department_id)
REFERENCES department_T(department_id)
ON UPDATE CASCADE ON DELETE RESTRICT);

/* Create a call on doctor table */
CREATE TABLE call_on_doctor_T
(cdoctor_id int(11) AUTO_INCREMENT NOT NULL,
fee_per_call double NOT NULL,
payment_due varchar(20) NOT NULL,
contact_address varchar(50),
CONSTRAINT call_on_doctor_pk PRIMARY KEY(cdoctor_id),
CONSTRAINT call_on_doctor_fk FOREIGN KEY(cdoctor_id) 
REFERENCES doctor_T(doctor_id) 
ON UPDATE CASCADE ON DELETE RESTRICT);


/* Create a regular doctor table */
CREATE TABLE regular_doctor_T
(rdoctor_id int(11) AUTO_INCREMENT NOT NULL,
office_address varchar(50),
salary double,
date_of_joining date,
CONSTRAINT regular_doctor_pk PRIMARY KEY(rdoctor_id),
CONSTRAINT regular_doctor_fk FOREIGN KEY(rdoctor_id) 
REFERENCES doctor_T(doctor_id) 
ON UPDATE CASCADE ON DELETE RESTRICT);

/* Create a patient table */
CREATE TABLE patient_T
(patientmembership_id int(11) AUTO_INCREMENT NOT NULL,
patient_last_name varchar(25) NOT NULL,
patient_middle_name varchar(25),
patient_first_name varchar(25) NOT NULL,
date_of_birth date,
Gender varchar(6),
rdoctor_id int(11) NOT NULL,
CONSTRAINT patient_pk PRIMARY KEY(patientmembership_id),
CONSTRAINT paitent_fk FOREIGN KEY(rdoctor_id)
REFERENCES regular_doctor_T(rdoctor_id)
ON UPDATE CASCADE ON DELETE RESTRICT);

/* Create a patient membership type table */
CREATE TABLE patient_membership_type_T
(patientmembership_id int(11) NOT NULL,
membership_type varchar(30) NOT NULL,
CONSTRAINT patient_membership_type_pk PRIMARY KEY(patientmembership_id, membership_type),
CONSTRAINT patient_membership_type_fk FOREIGN KEY(patientmembership_id) 
REFERENCES patient_T(patientmembership_id) 
ON UPDATE CASCADE ON DELETE RESTRICT);

/* Create a patient appointment table */
CREATE TABLE patient_appointment_T
(appointment_confirmation_number int(11) AUTO_INCREMENT NOT NULL,
appointment_date date NOT NULL,
appointment_location varchar(50) NOT NULL,
doctor__name varchar(25) NOT NULL,
rdoctor_id int(11) NOT NULL,
patientmembership_id int(11) NOT NULL,
CONSTRAINT patient_appointment_pk PRIMARY KEY(appointment_confirmation_number),
CONSTRAINT patient_appointment_fk1 FOREIGN KEY(rdoctor_id) 
REFERENCES regular_doctor_T(rdoctor_id)
ON UPDATE CASCADE ON DELETE RESTRICT,
CONSTRAINT patient_appointment_fk2 FOREIGN KEY(patientmembership_id)
REFERENCES patient_T(patientmembership_id)
ON UPDATE CASCADE ON DELETE RESTRICT);

/* Create a department facility table */
CREATE TABLE department_facility_T
(department_id int(11) NOT NULL,
department_facility varchar(30) NOT NULL,
CONSTRAINT department_facility_pk PRIMARY KEY(department_id, department_facility),
CONSTRAINT department_facility_fk FOREIGN KEY(department_id) 
REFERENCES department_T(department_id) 
ON UPDATE CASCADE ON DELETE RESTRICT);

/* Q2 */
/* Populating database with atleast 5 rows per table */
/* Department table */
INSERT INTO department_T (department_id, department_name, department_location) VALUES
(1, 'Outpatient Department', 'OPD'),
(2, 'Inpatient Service', 'Inpatient Unit'),
(3, 'Medical Unit', 'Clinic'),
(4, 'Operation Theatre', 'OT complex'),
(5, 'Radiology', 'X-ray unit');

/* Doctor table */
INSERT INTO doctor_T(doctor_id, doctor__name, qualification, phone_number, doctor_type, department_id) VALUES
(101, 'Zoe Handzel', 'Physician', 9254212341, 'Regular', 1),
(102, 'Abel Faught', 'Physician', 2708856356, 'Regular', 2),
(103, 'Ivan Taglieri', 'Surgeon', 9782794244, 'Call on', 3),
(104, 'Dane Rougeaux', 'Superspecialist', 7345365053, 'Call on', 4),
(105, 'Johnnie Scheller', 'Radiologist', 2103153163, 'Call on', 5);

/* Regular Doctor table */
INSERT INTO regular_doctor_T(rdoctor_id, office_address, salary, date_of_joining) VALUES
(101, '911 West University Lane North Attleboro MA 02760', 100000, '1997-04-17'),
(102, '9498 Albany Street Elyria OH 44035', 150000, '2021-10-28');

/* Call on doctor table */
INSERT INTO call_on_doctor_T(cdoctor_id, fee_per_call, payment_due, contact_address) VALUES
(103, 1000, '15 days', '534 Friendship Lane San Martin CA 95046'),
(104, 2500, '18 days', '3760 Bubby Drive Sacramento CA 95814'),
(105, 500, '3 days', '480 Woodstock Drive Baldwin Park CA 91706');

/* Patient table */
INSERT INTO patient_T(patientmembership_id, patient_last_name,patient_middle_name, patient_first_name, date_of_birth, gender, rdoctor_id) VALUES
(1001, 'Garret', 'Marguerite', 'David', '1924-05-08', 'Male', 102),
(1002, 'Jacobs', 'Evony', 'Abel', '1985-05-05', 'Female', 101),
(1003, 'Henson', 'Fernando', 'Kimora', '1945-07-08', 'Female', 101),
(1004, 'Moss', 'Harriet', 'Abbey', '1999-01-09', 'Female', 102),
(1005, 'May', 'Juan', 'Ansley', '1967-02-10', 'Male', 102),
(1006, 'Davidson', 'Jeremy', 'Jair', '1978-02-21', 'Male', 101);

/* Patient membership type table */
INSERT INTO patient_membership_type_T(patientmembership_id, membership_type) VALUES
(1001, 'Individual'),
(1002, 'Family'),
(1003, 'Non-member'),
(1004, 'Family'),
(1005, 'Individual'),
(1006, 'Individual');

/* Patient appointment table */
INSERT INTO patient_appointment_T(appointment_confirmation_number, appointment_date, appointment_location, doctor__name, rdoctor_id, patientmembership_id) VALUES
(10001, '2016-12-18', 'Inpatient Unit', 'Abel Faught', 102, 1001),
(10002, '1993-10-28', 'OPD', 'Zoe Handzel', 101, 1006),
(10003, '2005-10-28', 'Inpatient Unit', 'Abel Faught', 102, 1004),
(10004, '2008-12-13', 'Inpatient Unit', 'Abel Faught', 102, 1005),
(10005, '2021-01-31', 'OPD', 'Zoe Handzel', 101, 1003);

/* Department facility table */
INSERT INTO department_facility_T(department_id, department_facility) VALUES
(1, 'Primary care'),
(2, 'Rehabilitation center'),
(3, 'Specialized care center'),
(4, 'ECG, Ventilator'),
(5, 'CT Scan, MRA, MRI');

/* Display all tables */
SELECT * FROM department_T;
SELECT * FROM doctor_T;
SELECT * FROM call_on_doctor_T;
SELECT * FROM regular_doctor_T;
SELECT * FROM patient_T;
SELECT * FROM patient_membership_type_T;
SELECT * FROM patient_appointment_T;
SELECT * FROM department_facility_T;

/* Q3 */
SELECT patient_T.*, patient_appointment_T.appointment_date, patient_appointment_T.doctor__name FROM patient_T, patient_appointment_T
WHERE patient_T.patientmembership_id=patient_appointment_T.patientmembership_id
AND appointment_date='2021-01-31' AND doctor__name='Zoe Handzel';

/* Q4 */
SELECT doctor_T.*, regular_doctor_T.*, department_T.department_name FROM regular_doctor_T INNER JOIN doctor_T
ON regular_doctor_T.rdoctor_id=doctor_T.doctor_id
INNER JOIN department_T
ON doctor_T.department_id=department_T.department_id
WHERE doctor__name LIKE 'J%' AND doctor_type='Regular' and department_name='Inpatient Service';

SELECT doctor_T.*, regular_doctor_T.*, department_T.department_name FROM regular_doctor_T INNER JOIN doctor_T
ON regular_doctor_T.rdoctor_id=doctor_T.doctor_id
INNER JOIN department_T
ON doctor_T.department_id=department_T.department_id
WHERE doctor__name LIKE 'A%' AND doctor_type='Regular' and department_name='Inpatient Service';


/* Q5 */
SELECT * FROM department_T LEFT JOIN department_facility_T
ON department_T.department_id=department_facility_T.department_id;

/* Q6 */
SELECT call_on_doctor_T.cdoctor_id FROM call_on_doctor_T
UNION
SELECT regular_doctor_T.rdoctor_id FROM regular_doctor_T;

/* Q7 */
CREATE VIEW v_patient_info AS
SELECT patient_T.* FROM patient_T INNER JOIN regular_doctor_T
ON patient_T.rdoctor_id=regular_doctor_T.rdoctor_id
WHERE salary>100000;

SELECT* FROM v_patient_info;