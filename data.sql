/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (01, 'Agumon', '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (02, 'Gabumon', '2018-11-15', 2, TRUE, 8.00);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (03, 'Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (04, 'Devimon', '2017-05-12', 5, TRUE, 11.00);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (05, 'Chamander', '2020-02-08', 0, FALSE, -11.00);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (06, 'Plantmon', '2021-11-15', 2, TRUE, -5.70);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (07, 'Squirtle', '1993-04-02', 3, FALSE, -12.13);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (08, 'Angemon', '2005-06-12', 1, TRUE, -45);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (09, 'Boarmon', '2005-06-07', 7, TRUE, 20.40);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (10, 'Blossom', '1998-10-13', 3, TRUE, 17.00);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (11, 'Ditto', '2022-05-14', 4, TRUE, 22.00);

-- Insert data into the owners table:
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- Insert data into the species table:
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

-- Modify your inserted animals so it includes the species_id value: If the name ends in "mon" it will be Digimon. All other are Pokemon.
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 1
WHERE species_id ISNULL;

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Sam Smith')
WHERE name LIKE 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Jennifer Orwell')
WHERE name = 'Gabumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Jennifer Orwell')
WHERE name LIKE 'Pikachu';

-- Bob owns Devimon and Plantmon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIkE 'Bob')
WHERE name = 'Devimon'

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIkE 'Bob')
WHERE name = 'Plantmon'

-- Melody Pond owns Chamander, Squirtle, and Blossom
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Melody Pond')
WHERE name = 'Chamander';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Melody Pond')
WHERE name = 'Squirtle';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Melody Pond')
WHERE name = 'Blossom';

-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Dean Winchester')
WHERE name = 'Angemon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Dean Winchester')
WHERE name = 'Boarmon';
