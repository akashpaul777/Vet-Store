/*
  Database Unit 2024 Semester 1
  --Pets First Schema File and Initial Data--
  --pf_initialSchemaInsert.sql

  Description:
  This file creates the Pets First tables
  and populates several of the tables (those shown in purple on the supplied model).
  You should read this schema file carefully
  and be sure you understand the various data requirements.

Author: FIT Database Teaching Team
License: Copyright Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice.

*/

DROP TABLE animal CASCADE CONSTRAINTS PURGE;

DROP TABLE animal_type CASCADE CONSTRAINTS PURGE;

DROP TABLE clinic CASCADE CONSTRAINTS PURGE;

DROP TABLE drug CASCADE CONSTRAINTS PURGE;

DROP TABLE owner CASCADE CONSTRAINTS PURGE;

DROP TABLE service CASCADE CONSTRAINTS PURGE;

DROP TABLE specialisation CASCADE CONSTRAINTS PURGE;

DROP TABLE vet CASCADE CONSTRAINTS PURGE;

DROP TABLE visit CASCADE CONSTRAINTS PURGE;

DROP TABLE visit_drug CASCADE CONSTRAINTS PURGE;

DROP TABLE visit_service CASCADE CONSTRAINTS PURGE;

CREATE TABLE animal (
    animal_id       NUMBER(5) NOT NULL,
    animal_name     VARCHAR2(40) NOT NULL,
    animal_born     DATE NOT NULL,
    animal_deceased CHAR(1) NOT NULL,
    owner_id        NUMBER(5) NOT NULL,
    atype_id        NUMBER(3) NOT NULL
);

ALTER TABLE animal
    ADD CONSTRAINT chk_animal_deceased CHECK ( animal_deceased IN ( 'N', 'Y' ) );

COMMENT ON COLUMN animal.animal_id IS
    'Animal identifier';

COMMENT ON COLUMN animal.animal_name IS
    'Name for animal';

COMMENT ON COLUMN animal.animal_born IS
    'Date of birth of animal';

COMMENT ON COLUMN animal.animal_deceased IS
    'Is animal still alive (Y,N)';

COMMENT ON COLUMN animal.owner_id IS
    'Owner identifier';

COMMENT ON COLUMN animal.atype_id IS
    'Animal type identifier';

ALTER TABLE animal ADD CONSTRAINT animal_pk PRIMARY KEY ( animal_id );

CREATE TABLE animal_type (
    atype_id          NUMBER(3) NOT NULL,
    atype_description VARCHAR2(40) NOT NULL
);

COMMENT ON COLUMN animal_type.atype_id IS
    'Animal type identifier';

COMMENT ON COLUMN animal_type.atype_description IS
    'Animal type description';

ALTER TABLE animal_type ADD CONSTRAINT animal_type_pk PRIMARY KEY ( atype_id );

CREATE TABLE clinic (
    clinic_id      NUMBER(2) NOT NULL,
    clinic_name    VARCHAR2(50) NOT NULL,
    clinic_address VARCHAR2(80) NOT NULL,
    clinic_phone   CHAR(10) NOT NULL,
    vet_id         NUMBER(4) NOT NULL
);

COMMENT ON COLUMN clinic.clinic_id IS
    'Identifier for clinic';

COMMENT ON COLUMN clinic.clinic_name IS
    'Clinic business name';

COMMENT ON COLUMN clinic.clinic_address IS
    'Address of clinic';

COMMENT ON COLUMN clinic.clinic_phone IS
    'Contact phone number for the clinic';

COMMENT ON COLUMN clinic.vet_id IS
    'Identifier for the vet';

ALTER TABLE clinic ADD CONSTRAINT clinic_pk PRIMARY KEY ( clinic_id );

CREATE TABLE drug (
    drug_id       NUMBER(4) NOT NULL,
    drug_name     VARCHAR2(50) NOT NULL,
    drug_usage    VARCHAR2(100) NOT NULL,
    drug_std_cost NUMBER(5, 3) NOT NULL
);

COMMENT ON COLUMN drug.drug_id IS
    'Drug identifier';

COMMENT ON COLUMN drug.drug_name IS
    'Drug name';

COMMENT ON COLUMN drug.drug_usage IS
    'Drug usage instructions';

COMMENT ON COLUMN drug.drug_std_cost IS
    'Standard cost for drug';

ALTER TABLE drug ADD CONSTRAINT drug_pk PRIMARY KEY ( drug_id );

CREATE TABLE owner (
    owner_id         NUMBER(5) NOT NULL,
    owner_givenname  VARCHAR2(30),
    owner_familyname VARCHAR2(30),
    owner_phone      CHAR(10) NOT NULL
);

COMMENT ON COLUMN owner.owner_id IS
    'Owner identifier';

COMMENT ON COLUMN owner.owner_givenname IS
    'Owner given name';

COMMENT ON COLUMN owner.owner_familyname IS
    'Owner family name';

COMMENT ON COLUMN owner.owner_phone IS
    'Owner contact phone number';

ALTER TABLE owner ADD CONSTRAINT owner_pk PRIMARY KEY ( owner_id );

CREATE TABLE service (
    service_code     CHAR(5) NOT NULL,
    service_desc     VARCHAR2(50) NOT NULL,
    service_std_cost NUMBER(6, 2) NOT NULL
);

COMMENT ON COLUMN service.service_code IS
    'Service code identifier';

COMMENT ON COLUMN service.service_desc IS
    'Service description';

COMMENT ON COLUMN service.service_std_cost IS
    'Standard cost for service';

ALTER TABLE service ADD CONSTRAINT service_pk PRIMARY KEY ( service_code );

CREATE TABLE specialisation (
    spec_id          NUMBER(2) NOT NULL,
    spec_description VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN specialisation.spec_id IS
    'Specialisation identifier';

COMMENT ON COLUMN specialisation.spec_description IS
    'Decription of specialisation';

ALTER TABLE specialisation ADD CONSTRAINT specialisation_pk PRIMARY KEY ( spec_id );

CREATE TABLE vet (
    vet_id         NUMBER(4) NOT NULL,
    vet_givenname  VARCHAR2(30),
    vet_familyname VARCHAR2(30),
    vet_phone      CHAR(10) NOT NULL,
    vet_employed   DATE NOT NULL,
    spec_id        NUMBER(2),
    clinic_id      NUMBER(2) NOT NULL
);

COMMENT ON COLUMN vet.vet_id IS
    'Identifier for the vet';

COMMENT ON COLUMN vet.vet_givenname IS
    'Vets given name';

COMMENT ON COLUMN vet.vet_familyname IS
    'Vets family name';

COMMENT ON COLUMN vet.vet_phone IS
    'Vets contact number';

COMMENT ON COLUMN vet.vet_employed IS
    'Date the vet was first emploted by AD';

COMMENT ON COLUMN vet.spec_id IS
    'Specialisation identifier';

COMMENT ON COLUMN vet.clinic_id IS
    'Identifier for clinic';

ALTER TABLE vet ADD CONSTRAINT vet_pk PRIMARY KEY ( vet_id );

ALTER TABLE animal
    ADD CONSTRAINT animaltype_animal_fk FOREIGN KEY ( atype_id )
        REFERENCES animal_type ( atype_id );

ALTER TABLE animal
    ADD CONSTRAINT owner_animal_fk FOREIGN KEY ( owner_id )
        REFERENCES owner ( owner_id );

ALTER TABLE vet
    ADD CONSTRAINT clinic_vet_fk FOREIGN KEY ( clinic_id )
        REFERENCES clinic ( clinic_id );

ALTER TABLE vet
    ADD CONSTRAINT specialisation_vet_fk FOREIGN KEY ( spec_id )
        REFERENCES specialisation ( spec_id );

ALTER TABLE clinic
    ADD CONSTRAINT vet_clinic_fk FOREIGN KEY ( vet_id )
        REFERENCES vet ( vet_id );

--Loading initial data
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (101, 'Amoxicillin', 'Used for bacterial infections; 5 mg per kg twice daily', 12);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (102, 'Rabies Vaccine', 'Routine rabies vaccination for pets', 99.99);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (103, 'Microchip', 'Electronic microchip for pet identification', 50);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (104, 'Epinephrine', 'Emergency treatment for allergic reactions; 0.1 mg per kg', 70);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (105, 'Ketamine', 'Anesthetic used for surgeries; dosage depends on the pet''s weight', 50);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (106, 'Chlorhexidine', 'Antiseptic for dental cleaning; use as directed', 10);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (107, 'Ivermectin', 'Used for heartworm prevention; 0.1 mg per kg monthly', 16);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (108, 'Fipronil', 'Topical treatment for fleas and ticks; apply once monthly', 45);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (109, 'Corticosteroids', 'For skin allergies; dosage as prescribed', 4.5);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (110, 'Clotrimazole', 'Ear infection treatment; apply inside ear as directed', 30);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (111, 'General Health Supplements', 'Supplements for overall health; one tablet daily', 1.2);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (112, 'Barium', 'Contrast medium for X-rays; dosage per vet''s instructions', 15);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (113, 'Sonographic Gel', 'Ultrasound gel; apply as needed for procedures', 3);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (114, 'Buprenorphine', 'Analgesic for post-surgery pain relief; 0.01 mg per kg', 14);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (115, 'Chemotherapy Agents', 'Chemotherapeutic agents for cancer treatment; as per oncologist''s regimen', 50);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (116, 'Heart Medications', 'Cardiology meds; follow vet''s prescription', 8);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (117, 'Glucosamine', 'For joint health in senior pets; 500 mg daily', 1.5);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (118, 'Puppy/Kitten Vitamins', 'Vitamins for young pets; according to the age and weight', 40);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (119, 'Dietary Supplements', 'Nutritional supplements; per dietary needs', 1);
INSERT INTO drug (drug_id, drug_name, drug_usage, drug_std_cost) VALUES (120, 'Behavioral Modifiers', 'Medication to aid in behavioral training; dosage as instructed', 80);

INSERT INTO specialisation (spec_id, spec_description) VALUES (1, 'General Practice');
INSERT INTO specialisation (spec_id, spec_description) VALUES (2, 'Vaccinology');
INSERT INTO specialisation (spec_id, spec_description) VALUES (3, 'Microchipping');
INSERT INTO specialisation (spec_id, spec_description) VALUES (4, 'Emergency Medicine');
INSERT INTO specialisation (spec_id, spec_description) VALUES (5, 'Surgical Procedures');
INSERT INTO specialisation (spec_id, spec_description) VALUES (6, 'Dentistry');
INSERT INTO specialisation (spec_id, spec_description) VALUES (7, 'Parasitology');
INSERT INTO specialisation (spec_id, spec_description) VALUES (8, 'Dermatology');
INSERT INTO specialisation (spec_id, spec_description) VALUES (9, 'Otolaryngology');
INSERT INTO specialisation (spec_id, spec_description) VALUES (10, 'Diagnostic Imaging');
INSERT INTO specialisation (spec_id, spec_description) VALUES (11, 'Oncology');
INSERT INTO specialisation (spec_id, spec_description) VALUES (12, 'Cardiology');
INSERT INTO specialisation (spec_id, spec_description) VALUES (13, 'Gerontology');
INSERT INTO specialisation (spec_id, spec_description) VALUES (14, 'Pediatrics');
INSERT INTO specialisation (spec_id, spec_description) VALUES (15, 'Nutrition');
INSERT INTO specialisation (spec_id, spec_description) VALUES (16, 'Behavioral Medicine');

ALTER TABLE CLINIC DISABLE CONSTRAINT VET_CLINIC_FK;

INSERT INTO clinic (clinic_id, clinic_name, clinic_address, clinic_phone, vet_id) VALUES (1, 'East Melbourne Veterinary Center',  '47 Blackburn Road, Burwood East VIC 3151', '0398123456', 1001);
INSERT INTO clinic (clinic_id, clinic_name, clinic_address, clinic_phone, vet_id) VALUES (2, 'Northern Suburbs Animal Hospital',  '78 High St, Thornbury VIC 3071', '0390215478', 1003);
INSERT INTO clinic (clinic_id, clinic_name, clinic_address, clinic_phone, vet_id) VALUES (3, 'Bayside Veterinary Clinic',  '32 Bay Rd, Sandringham VIC 3191', '0398765433', 1004);
INSERT INTO clinic (clinic_id, clinic_name, clinic_address, clinic_phone, vet_id) VALUES (4, 'Glen Iris Vet Clinic',  '1501 High St, Glen Iris VIC 3146', '0398123458', 1002);
INSERT INTO clinic (clinic_id, clinic_name, clinic_address, clinic_phone, vet_id) VALUES (5, 'Brighton East Pet Care',  '123 Thomas St, Brighton East VIC 3187', '0398765412', 1007);

INSERT INTO PlayerRating (RatingID, PlayerID, ScoutID, Rating, RatingDate) VALUES (1, 1, 1, 85, TO_DATE('2023-01-01', 'YYY-MM-DD'));
INSERT INTO vet (vet_id, vet_givenname, vet_familyname, vet_phone, vet_employed, spec_id, clinic_id) VALUES (1001, 'Emily', 'Tanner', '0456789123', TO_DATE('2024-01-08', 'YYYY-MM-DD'), 1, 1);
INSERT INTO vet (vet_id, vet_givenname, vet_familyname, vet_phone, vet_employed, spec_id, clinic_id) VALUES (1002, 'Lucas', 'Bennet', '0456234598', TO_DATE('2024-01-15', 'YYYY-MM-DD'), 8, 4);
INSERT INTO vet (vet_id, vet_givenname, vet_familyname, vet_phone, vet_employed, spec_id, clinic_id) VALUES (1003, 'John', null, '0456123498', TO_DATE('2024-01-19', 'YYYY-MM-DD'), 4, 2);
INSERT INTO vet (vet_id, vet_givenname, vet_familyname, vet_phone, vet_employed, spec_id, clinic_id) VALUES (1004, 'Anna', 'Kowalski', '0456987123', TO_DATE('2024-01-31', 'YYYY-MM-DD'), 6, 3);
INSERT INTO vet (vet_id, vet_givenname, vet_familyname, vet_phone, vet_employed, spec_id, clinic_id) VALUES (1005, 'Owen', 'Murphy', '0482345678', TO_DATE('2024-02-02', 'YYYY-MM-DD'), null, 2);
INSERT INTO vet (vet_id, vet_givenname, vet_familyname, vet_phone, vet_employed, spec_id, clinic_id) VALUES (1006, 'Sophie', 'Grant', '0487654321', TO_DATE('2024-02-14', 'YYYY-MM-DD'), 8, 1);
INSERT INTO vet (vet_id, vet_givenname, vet_familyname, vet_phone, vet_employed, spec_id, clinic_id) VALUES (1007, 'Jessica', 'Lee', '0456567891', TO_DATE('2024-02-25', 'YYYY-MM-DD'), 16, 5);
INSERT INTO vet (vet_id, vet_givenname, vet_familyname, vet_phone, vet_employed, spec_id, clinic_id) VALUES (1008, null, 'Watson', '0489123456', TO_DATE('2024-03-08', 'YYYY-MM-DD'), null, 3);
INSERT INTO vet (vet_id, vet_givenname, vet_familyname, vet_phone, vet_employed, spec_id, clinic_id) VALUES (1009, 'Sarah', 'Morris', '0456345987', TO_DATE('2024-03-17', 'YYYY-MM-DD'), null, 5);
INSERT INTO vet (vet_id, vet_givenname, vet_familyname, vet_phone, vet_employed, spec_id, clinic_id) VALUES (1010, 'Michael', 'Clarkson', '0456456798', TO_DATE('2024-03-24', 'YYYY-MM-DD'), 12, 5);
INSERT INTO vet (vet_id, vet_givenname, vet_familyname, vet_phone, vet_employed, spec_id, clinic_id) VALUES (1011, 'Liam', 'Foster', '0486789123', TO_DATE('2024-03-24', 'YYYY-MM-DD'), 12, 4);

ALTER TABLE CLINIC ENABLE CONSTRAINT VET_CLINIC_FK;

INSERT INTO owner (owner_id, owner_givenname, owner_familyname, owner_phone) VALUES (1, 'Olivia', 'Smith', '0491570156');
INSERT INTO owner (owner_id, owner_givenname, owner_familyname, owner_phone) VALUES (2, 'William', null, '0482657142');
INSERT INTO owner (owner_id, owner_givenname, owner_familyname, owner_phone) VALUES (3, 'Lucas', 'Williams', '0473682956');
INSERT INTO owner (owner_id, owner_givenname, owner_familyname, owner_phone) VALUES (4, 'Mia', 'Brown', '0491742368');
INSERT INTO owner (owner_id, owner_givenname, owner_familyname, owner_phone) VALUES (5, 'Jack', 'Jones', '0482563910');
INSERT INTO owner (owner_id, owner_givenname, owner_familyname, owner_phone) VALUES (6, null, 'Garcia', '0492367250');
INSERT INTO owner (owner_id, owner_givenname, owner_familyname, owner_phone) VALUES (7, 'Charlotte', 'Miller', '0492423123');
INSERT INTO owner (owner_id, owner_givenname, owner_familyname, owner_phone) VALUES (8, 'Liam', 'Davis', '0491563824');
INSERT INTO owner (owner_id, owner_givenname, owner_familyname, owner_phone) VALUES (9, 'Sophia', 'Rodriguez', '0481795462');
INSERT INTO owner (owner_id, owner_givenname, owner_familyname, owner_phone) VALUES (10, 'James', 'Martinez', '0492781954');

INSERT INTO animal_type (atype_id, atype_description) VALUES (1, 'Dog');
INSERT INTO animal_type (atype_id, atype_description) VALUES (2, 'Cat');
INSERT INTO animal_type (atype_id, atype_description) VALUES (3, 'Bird');
INSERT INTO animal_type (atype_id, atype_description) VALUES (4, 'Fish');
INSERT INTO animal_type (atype_id, atype_description) VALUES (5, 'Rabbit');
INSERT INTO animal_type (atype_id, atype_description) VALUES (6, 'Guinea Pig');
INSERT INTO animal_type (atype_id, atype_description) VALUES (7, 'Ferret');
INSERT INTO animal_type (atype_id, atype_description) VALUES (8, 'Reptile');
INSERT INTO animal_type (atype_id, atype_description) VALUES (9, 'Amphibian');
INSERT INTO animal_type (atype_id, atype_description) VALUES (10, 'Horse');

INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (1, 'Buddy', TO_DATE('2017-04-15', 'YYYY-MM-DD'), 'N', 1, 1);
INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (2, 'Charlie', TO_DATE('2018-08-23', 'YYYY-MM-DD'), 'N', 1, 1);
INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (3, 'Whiskers', TO_DATE('2016-05-11', 'YYYY-MM-DD'), 'N', 2, 2);
INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (4, 'Max', TO_DATE('2019-02-09', 'YYYY-MM-DD'), 'N', 3, 1);
INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (5, 'Tweety', TO_DATE('2018-07-07', 'YYYY-MM-DD'), 'N', 4, 3);
INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (6, 'Thumper', TO_DATE('2017-11-21', 'YYYY-MM-DD'), 'N', 5, 5);
INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (7, 'Oreo', TO_DATE('2018-06-01', 'YYYY-MM-DD'), 'N', 5, 5);
INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (8, 'Bailey', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'N', 6, 1);
INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (9, 'Shadow', TO_DATE('2019-04-25', 'YYYY-MM-DD'), 'N', 7, 2);
INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (10, 'Rocky', TO_DATE('2017-07-17', 'YYYY-MM-DD'), 'N', 8, 1);
INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (11, 'Smokey', TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'N', 9, 2);
INSERT INTO animal (animal_id, animal_name, animal_born, animal_deceased, owner_id, atype_id) VALUES (12, 'Rex', TO_DATE('2024-03-12', 'YYYY-MM-DD'), 'N', 10, 1);

INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S001', 'General Consultation', 60);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S002', 'Vaccination - Routine', 45);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S003', 'Microchipping', 70);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S004', 'Emergency Care', 150);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S005', 'Spay/Neuter Surgery', 125);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S006', 'Dental Cleaning', 80);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S007', 'Heartworm Prevention', 50);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S008', 'Flea and Tick Treatment', 40);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S009', 'Skin Allergy Treatment', 85);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S010', 'Ear Infection Treatment', 75);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S011', 'Annual Health Checkup', 90);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S012', 'X-Ray Imaging', 100);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S013', 'Ultrasound', 110);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S014', 'Orthopedic Surgery', 200);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S015', 'Oncology Consultation', 140);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S016', 'Cardiology Examination', 130);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S017', 'Senior Pet Care Program', 100);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S018', 'Puppy/Kitten Health Program', 120);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S019', 'Nutritional Counseling', 50);
INSERT INTO service (service_code, service_desc, service_std_cost) VALUES ( 'S020', 'Behavioral Training Session', 90);

COMMIT;



-- Insert data into Team Table
INSERT INTO Team (TeamID, TeamName, TeamLocation) VALUES (1, 'Yankees', 'New York');
INSERT INTO Team (TeamID, TeamName, TeamLocation) VALUES (2, 'Dodgers', 'Los Angeles');
INSERT INTO Team (TeamID, TeamName, TeamLocation) VALUES (3, 'Red Sox', 'Boston');

-- Insert data into Scout Table
INSERT INTO Scout (ScoutID, ScoutName, PhoneNumber, TeamID) VALUES (1, 'John Doe', '123-456-7890', 1);
INSERT INTO Scout (ScoutID, ScoutName, PhoneNumber, TeamID) VALUES (2, 'Jane Smith', '234-567-8901', 2);
INSERT INTO Scout (ScoutID, ScoutName, PhoneNumber, TeamID) VALUES (3, 'Jim Brown', '345-678-9012', 3);

-- Insert data into Agent Table
INSERT INTO Agent (AgentID, AgentName, PhoneNumber) VALUES (1, 'Mike Johnson', '456-789-0123');
INSERT INTO Agent (AgentID, AgentName, PhoneNumber) VALUES (2, 'Emily Davis', '567-890-1234');
INSERT INTO Agent (AgentID, AgentName, PhoneNumber) VALUES (3, 'Sarah Wilson', '678-901-2345');

-- Insert data into Players Table
INSERT INTO Players (PlayerID, FirstName, LastName, PlayerRating, PhoneNumber, TeamID) VALUES (1, 'Player1', 'Lastname1', 85, '789-012-3456', 1);
INSERT INTO Players (PlayerID, FirstName, LastName, PlayerRating, PhoneNumber, TeamID) VALUES (2, 'Player2', 'Lastname2', 90, '890-123-4567', 1);
INSERT INTO Players (PlayerID, FirstName, LastName, PlayerRating, PhoneNumber, TeamID) VALUES (3, 'Player3', 'Lastname3', 78, '901-234-5678', 1);
INSERT INTO Players (PlayerID, FirstName, LastName, PlayerRating, PhoneNumber, TeamID) VALUES (4, 'Player4', 'Lastname4', 88, '012-345-6789', 2);
INSERT INTO Players (PlayerID, FirstName, LastName, PlayerRating, PhoneNumber, TeamID) VALUES (5, 'Player5', 'Lastname5', 92, '123-456-7890', 2);
INSERT INTO Players (PlayerID, FirstName, LastName, PlayerRating, PhoneNumber, TeamID) VALUES (6, 'Player6', 'Lastname6', 80, '234-567-8901', 2);
INSERT INTO Players (PlayerID, FirstName, LastName, PlayerRating, PhoneNumber, TeamID) VALUES (7, 'Player7', 'Lastname7', 83, '345-678-9012', 3);
INSERT INTO Players (PlayerID, FirstName, LastName, PlayerRating, PhoneNumber, TeamID) VALUES (8, 'Player8', 'Lastname8', 95, '456-789-0123', 3);
INSERT INTO Players (PlayerID, FirstName, LastName, PlayerRating, PhoneNumber, TeamID) VALUES (9, 'Player9', 'Lastname9', 89, '567-890-1234', 3);


-- Insert data into PlayerRating Table
INSERT INTO PlayerRating (RatingID, PlayerID, ScoutID, Rating, RatingDate) VALUES (1, 1, 1, 85, TO_DATE('2023-01-01', 'YYYY-MM-DD'));
INSERT INTO PlayerRating (RatingID, PlayerID, ScoutID, Rating, RatingDate) VALUES (2, 2, 1, 90, TO_DATE('2023-01-02','YYYY-MM-DD'));
INSERT INTO PlayerRating (RatingID, PlayerID, ScoutID, Rating, RatingDate) VALUES (3, 3, 2, 78, TO_DATE('2023-01-03','YYYY-MM-DD'));
INSERT INTO PlayerRating (RatingID, PlayerID, ScoutID, Rating, RatingDate) VALUES (4, 4, 2, 88, TO_DATE('2023-01-04','YYYY-MM-DD'));
INSERT INTO PlayerRating (RatingID, PlayerID, ScoutID, Rating, RatingDate) VALUES (5, 5, 3, 92, TO_DATE('2023-01-05','YYYY-MM-DD'));
INSERT INTO PlayerRating (RatingID, PlayerID, ScoutID, Rating, RatingDate) VALUES (6, 6, 3, 80, TO_DATE('2023-01-06','YYYY-MM-DD'));

-- Insert data into ScoutingReport Table
INSERT INTO ScoutingReport (ReportID, PlayerID, ScoutID, Filename, ReportDate) VALUES (1, 1, 1, 'report1.pdf', TO_DATE('2023-01-10','YYYY-MM-DD'));
INSERT INTO ScoutingReport (ReportID, PlayerID, ScoutID, Filename, ReportDate) VALUES (2, 2, 1, 'report2.pdf', TO_DATE('2023-01-11','YYYY-MM-DD'));
INSERT INTO ScoutingReport (ReportID, PlayerID, ScoutID, Filename, ReportDate) VALUES (3, 3, 2, 'report3.pdf', TO_DATE('2023-01-12','YYYY-MM-DD'));
INSERT INTO ScoutingReport (ReportID, PlayerID, ScoutID, Filename, ReportDate) VALUES (4, 4, 2, 'report4.pdf', TO_DATE('2023-01-13','YYYY-MM-DD'));
INSERT INTO ScoutingReport (ReportID, PlayerID, ScoutID, Filename, ReportDate) VALUES (5, 5, 3, 'report5.pdf', TO_DATE('2023-01-14','YYYY-MM-DD'));
INSERT INTO ScoutingReport (ReportID, PlayerID, ScoutID, Filename, ReportDate) VALUES (6, 6, 3, 'report6.pdf', TO_DATE('2023-01-15',"YYY-MM-DD"));