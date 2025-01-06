--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T1-pf-schema.sql

--Student ID: [Your Student ID]
--Student Name: [Your Name]

/* Comments for your marker:


*/

-- Task 1 Add Create table statements for the Missing TABLES below.
-- Ensure all column comments, and constraints (other than FK's) are included. 
-- FK constraints are to be added at the end of this script

-- VISIT
CREATE TABLE visit (
    visit_id NUMBER(5) NOT NULL,
    visit_date_time CHAR(19) NOT NULL,
    visit_length NUMBER(3) NOT NULL CHECK (visit_length BETWEEN 30 AND 90),
    visit_notes VARCHAR2(400),
    visit_weight NUMBER(5, 2),
    visit_total_cost NUMBER(10, 2) NOT NULL,
    animal_id NUMBER(5) NOT NULL,
    vet_id NUMBER(5) NOT NULL,
    clinic_id NUMBER(2) NOT NULL,
    from_visit_id NUMBER(5),
    PRIMARY KEY (visit_id)
);

COMMENT ON COLUMN visit.visit_id IS 'Identifier for visit';
COMMENT ON COLUMN visit.visit_date_time IS 'Date and time of visit';
COMMENT ON COLUMN visit.visit_length IS 'Visit length in minutes (30-90 minutes)';
COMMENT ON COLUMN visit.visit_notes IS 'Vet notes from visit';
COMMENT ON COLUMN visit.visit_weight IS 'Weight in Kgs';
COMMENT ON COLUMN visit.visit_total_cost IS 'Total cost for this visit';
COMMENT ON COLUMN visit.animal_id IS 'Animal identifier';
COMMENT ON COLUMN visit.vet_id IS 'Identifier for the vet';
COMMENT ON COLUMN visit.clinic_id IS 'Identifier for the clinic';
COMMENT ON COLUMN visit.from_visit_id IS 'The previous visit’s identifier (for follow-up visit only)';

-- VISIT_DRUG
CREATE TABLE visit_drug (
    visit_id NUMBER(5) NOT NULL,
    drug_id NUMBER(5) NOT NULL,
    visit_drug_dose VARCHAR2(100) NOT NULL,
    visit_drug_frequency VARCHAR2(100) NOT NULL,
    visit_drug_qtysupplied NUMBER(5) NOT NULL,
    visit_drug_linecost NUMBER(10, 2) NOT NULL,
    PRIMARY KEY (visit_id, drug_id)
);

COMMENT ON COLUMN visit_drug.visit_id IS 'Identifier for visit';
COMMENT ON COLUMN visit_drug.drug_id IS 'Drug identifier';
COMMENT ON COLUMN visit_drug.visit_drug_dose IS 'Dose prescribed in this visit';
COMMENT ON COLUMN visit_drug.visit_drug_frequency IS 'Frequency prescribed for this drug for this visit';
COMMENT ON COLUMN visit_drug.visit_drug_qtysupplied IS 'Quantity of drug supplied';
COMMENT ON COLUMN visit_drug.visit_drug_linecost IS 'Cost charged for drug in this visit';

-- VISIT_SERVICE
CREATE TABLE visit_service (
    visit_id NUMBER(5) NOT NULL,
    service_code CHAR(5) NOT NULL,
    visit_service_linecost NUMBER(10, 2) NOT NULL,
    PRIMARY KEY (visit_id, service_code)
);

COMMENT ON COLUMN visit_service.visit_id IS 'Identifier for visit';
COMMENT ON COLUMN visit_service.service_code IS 'Service identifier';
COMMENT ON COLUMN visit_service.visit_service_linecost IS 'Cost charged for this service in this visit';


--FK Constraints for visit table
ALTER TABLE visit ADD CONSTRAINT fk_visit_animal FOREIGN KEY (animal_id) REFERENCES animal(animal_id);
ALTER TABLE visit ADD CONSTRAINT fk_visit_vet FOREIGN KEY (vet_id) REFERENCES vet(vet_id);
ALTER TABLE visit ADD CONSTRAINT fk_visit_clinic FOREIGN KEY (clinic_id) REFERENCES clinic(clinic_id);
ALTER TABLE visit ADD CONSTRAINT fk_visit_from_visit FOREIGN KEY (from_visit_id) REFERENCES visit(visit_id);

--FK Constraints for visit_drug table
ALTER TABLE visit_drug ADD CONSTRAINT fk_visit_id FOREIGN KEY (visit_id) REFERENCES visit(visit_id);
ALTER TABLE visit_drug ADD CONSTRAINT fk_drug_id FOREIGN KEY (drug_id) REFERENCES drug(drug_id);

-- FK Constraints for visit_service table
ALTER TABLE visit_service ADD CONSTRAINT fk_visit_id_s FOREIGN KEY (visit_id) REFERENCES visit(visit_id);
ALTER TABLE visit_service ADD CONSTRAINT fk_service_code FOREIGN KEY (service_code) REFERENCES service(service_code);