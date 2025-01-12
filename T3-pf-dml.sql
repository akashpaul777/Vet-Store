--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-pf-dml.sql

--Student ID: [Your Student ID]
--Student Name: [Your Name]

/* Comments for your marker:


*/

-- Task 3: DML

-- 1. Create an Oracle Sequence for the VISIT table primary key
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE visit_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -02289 THEN -- Ignore error if sequence does not exist
            RAISE;
        END IF;
END;
/

CREATE SEQUENCE visit_seq
    START WITH 100
    INCREMENT BY 10;
/

-- Start the transaction
BEGIN

    -- 2. Insert Visit Booking
    -- Jack JONES books a visit for Oreo
    DECLARE
        v_visit_id NUMBER;
    BEGIN
        SELECT visit_seq.NEXTVAL INTO v_visit_id FROM dual;
        
        INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
        VALUES (v_visit_id, '2024-05-19 14:00:00', 30, NULL, NULL, 0, 
                (SELECT animal_id FROM animal WHERE animal_name = 'Oreo' AND owner_id = (SELECT owner_id FROM owner WHERE owner_givenname = 'Jack JONES')), 
                (SELECT vet_id FROM vet WHERE vet_givenname = 'Anna KOWALSKI'), 3, NULL);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END;

    -- 3. Update Visit Details
    -- Oreo's visit on 19 May 2024
    BEGIN
        UPDATE visit
        SET visit_notes = 'Ear infection treatment',
            visit_length = 45,
            visit_total_cost = (SELECT service_std_cost FROM service WHERE service_code = 'S010')
        WHERE visit_id = (SELECT visit_id FROM visit WHERE visit_date_time = '2024-05-19 14:00:00' AND animal_id = (SELECT animal_id FROM animal WHERE animal_name = 'Oreo'));
        
        INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
        VALUES ((SELECT visit_id FROM visit WHERE visit_date_time = '2024-05-19 14:00:00' AND animal_id = (SELECT animal_id FROM animal WHERE animal_name = 'Oreo')), 
                (SELECT drug_id FROM drug WHERE drug_name = 'Clotrimazole'), 
                '10mg', 'Twice daily', 1, 20);
                
        INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
        VALUES (visit_seq.NEXTVAL, '2024-05-26 14:00:00', 30, 'Follow-up for ear infection', NULL, 0, 
                (SELECT animal_id FROM animal WHERE animal_name = 'Oreo'), 
                (SELECT vet_id FROM vet WHERE vet_givenname = 'Anna KOWALSKI'), 3, 
                (SELECT visit_id FROM visit WHERE visit_date_time = '2024-05-19 14:00:00' AND animal_id = (SELECT animal_id FROM animal WHERE animal_name = 'Oreo')));
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END;

    -- 4. Cancel Visit
    -- Jack JONES cancels Oreo’s follow-up visit
    BEGIN
        DELETE FROM visit
        WHERE visit_date_time = '2024-05-26 14:00:00' AND animal_id = (SELECT animal_id FROM animal WHERE animal_name = 'Oreo');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END;

    -- Commit the transaction
    COMMIT;

END;
