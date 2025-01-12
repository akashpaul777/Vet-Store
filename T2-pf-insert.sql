/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-pf-insert.sql

--Student ID: [Your Student ID]
--Student Name: [Your Name]

/* Comments for your marker:


*/

--Begin transaction

SET TRANSACTION READ WRITE;
--------------------------------------
--INSERT INTO visit
--------------------------------------

-- Using valid IDs from the assumed structure of the initialization script
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (1, TO_DATE('2024-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 60, 'Annual check-up', 12.5, 90, 1, 1001, 2, NULL);

INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (2, TO_DATE('2024-04-03 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 45, 'Dental cleaning', 15.0, 80, 1, 1011,1, NULL);

INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (3, TO_DATE('2024-04-05 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 30, 'Microchipping', 10.5, 70, 5, 1002, 3, NULL);

INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (4, TO_DATE('2024-04-10 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 60, 'Emergency care', 13.0, 150, 2, 1004, 2, NULL);

INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (5, TO_DATE('2024-04-15 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 90, 'Spay surgery', 8.0, 125, 8, 1001, 4, NULL);

INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (6, TO_DATE('2024-04-20 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 60, 'Skin allergy treatment', 20.0, 85, 5, 1011, 4, NULL);

INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (7, TO_DATE('2024-04-25 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 30, 'Ear infection treatment', 7.5, 75, 9, 1009, 1, NULL);

INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (8, TO_DATE('2024-05-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 45, 'Heartworm prevention', 18.0, 50, 2, 1003, 2, NULL);

INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (9, TO_DATE('2024-05-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 60, 'Follow-up visit', 12.0, 0, 2, 1002, 5, 1);

INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (10, TO_DATE('2024-05-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 60, 'Future booking', NULL, 0, 6, 1006, 5, NULL);

--------------------------------------
--INSERT INTO visit_service
--------------------------------------

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (1, 'S001', 90);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (2, 'S006', 80);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (3, 'S003', 70);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (4, 'S004', 150);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (5, 'S005', 125);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (6, 'S009', 85);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (7, 'S010', 75);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (8, 'S007', 50);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (9, 'S009', 85);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (10, 'S001', 0);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (6, 'S001', 90);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (7, 'S002', 60);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (8, 'S003', 70);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (9, 'S004', 150);

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (5, 'S002', 60);

--------------------------------------
--INSERT INTO visit_drug
--------------------------------------

INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (4, 101, '500mg', 'Once daily', 1, 20);

INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (5, 104, '10mg', 'Twice daily', 2, 40);

INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (6, 107, '50mg', 'Once weekly', 1, 30);

INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (7, 109, '20mg', 'Twice weekly', 1, 25);

INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (8, 104, '100mg', 'Once monthly', 1, 15);

-- Visit 8 with one drug prescribed
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (8, 109, '200mg', 'Once daily', 1, 10);

-- Visit 9 with two drugs prescribed
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (9, 101, '500mg', 'Once daily', 1, 20);

INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (9, 104, '10mg', 'Twice daily', 2, 40);

-- Visit 10 with one drug prescribed
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (10, 107, '50mg', 'Once weekly', 1, 30);

-- Visit 1 with one drug prescribed
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (1, 101, '20mg', 'Twice weekly', 1, 25);

COMMIT;