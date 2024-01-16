/*File name: Lab5.txt
Name: Sujan Rokad
Date: October 24, 2023
Statement of Authorship: “I, Sujan Rokad, student number 000882948,
certify that this material is my original work. No other person's work has
been used without due acknowledgment and I have not made my work available
to anyone else.”
*/
USE chdb

PRINT 'GROUP 1 SELECT A'
SELECT COUNT(*) AS Children_Under_18
FROM patients
WHERE DATEDIFF(YEAR, birth_date, GETDATE()) < 18;


PRINT 'GROUP 1 SELECT B'
SELECT COUNT(*) AS Male_Count
FROM patients
WHERE gender = 'M'
AND patient_weight < (SELECT AVG(patient_weight) FROM patients WHERE
gender = 'F');


PRINT 'GROUP 1 SELECT D'
SELECT TOP 1 first_name, 
			last_name, 
			allergies, 
			patient_weight
FROM patients
WHERE province_id <> 'ON' AND (allergies IS NULL OR allergies = '') AND
patient_weight < 75;


PRINT 'GROUP 2 SELECT C'
SELECT province_id, COUNT(*) AS Patient_Count
FROM patients
WHERE province_id != 'ON'
GROUP BY province_id;


PRINT 'GROUP 2 SELECT D'
SELECT gender, COUNT(*) AS Patient_Count
FROM patients
WHERE patient_height > 175
GROUP BY gender;


PRINT 'GROUP 3 SELECT B'
SELECT U.pharmacist_initials, 
		U.entered_date, 
		U.dosage
FROM unit_dose_orders U
JOIN medications m ON U.medication_id = m.medication_id
WHERE M.medication_description = 'Morphine'
ORDER BY pharmacist_initials;


PRINT 'GROUP 3 SELECT D'
SELECT d.department_id, 
		d.department_name, 
		d.manager_first_name,
d.manager_last_name, p.purchase_order_id, p.total_amount
FROM departments d
JOIN purchase_orders p ON d.department_id = p.department_id
WHERE total_amount > 1500.00
ORDER BY department_id


PRINT 'GROUP 4 SELECT A'
SELECT P.physician_id, 
		P.first_name, 
		P.last_name, 
		P.specialty
FROM physicians P
JOIN encounters e ON p.physician_id = e.physician_id
JOIN patients pt ON e.patient_id = pt.patient_id
WHERE pt.first_name = 'Walter' AND pt.last_name = 'Mitty'


PRINT 'GROUP 4 SELECT B'
SELECT p.patient_id, 
		p.first_name,	
		p.last_name, 
		n.nursing_unit_id, 
		n.primary_diagnosis
FROM patients p
JOIN admissions n ON p.patient_id = n.patient_id
JOIN physicians ph ON n.attending_physician_id = ph.physician_id
WHERE ph.specialty = 'Internist' AND n.discharge_date IS NULL;


PRINT 'GROUP 5 SELECT B'
SELECT CONCAT(p.first_name, ' ' , p.last_name) AS patient,
		N.nursing_unit_id, 
		A.room, 
		M.medication_description
FROM patients AS p
JOIN admissions AS A ON p.patient_id = A.patient_id
JOIN nursing_units AS N ON A.nursing_unit_id = N.nursing_unit_id
JOIN medications as M ON A.admission_id = M.medication_id
WHERE A.discharge_date IS NULL AND p.allergies = 'Penicillin';


PRINT 'GROUP 6 SELECT B'
SELECT purchase_orders.purchase_order_id, 
		purchase_orders.order_date, 
		purchase_orders.department_id
FROM purchase_orders
WHERE NOT EXISTS (
	SELECT 1
	FROM purchase_order_lines
	WHERE
	purchase_order_lines.purchase_order_id = purchase_orders.purchase_order_id
)