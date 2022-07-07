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

-- Insert data into the vets table:
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

-- Insert data into the specializations table:
-- Vet William Tatcher is specialized in pokemon
INSERT INTO specializations (vets_id, species_id) VALUES (
  (SELECT vets.id FROM vets WHERE name LIKE 'William Tatcher'),
  (SELECT species.id FROM species WHERE species.name LIKE 'Pokemon')
);

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO specializations (vets_id, species_id) VALUES (
  (SELECT vets.id FROM vets WHERE name LIKE 'Stephanie Mendez'),
  (SELECT species.id FROM species WHERE species.name LIKE 'Pokemon')
);

INSERT INTO specializations (vets_id, species_id) VALUES (
  (SELECT vets.id FROM vets WHERE name LIKE 'Stephanie Mendez'),
  (SELECT species.id FROM species WHERE species.name LIKE 'Digimon')
);

-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations (vets_id, species_id) VALUES (
  (SELECT vets.id FROM vets WHERE name LIKE 'Jack Harkness'),
  (SELECT species.id FROM species WHERE species.name LIKE 'Digimon')
);

-- Insert the following data for visits:
-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Agumon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'William Tatcher'),
  '2020-05-24'
);

-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Agumon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Stephanie Mendez'),
  '2020-07-22'
);

-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Gabumon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Jack Harkness'),
  '2021-02-02'
);

-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Pikachu'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Maisy Smith'),
  '2020-01-05'
);

-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Pikachu'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Maisy Smith'),
  '2020-03-08'
);

-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Pikachu'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Maisy Smith'),
  '2020-04-14'
);

-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Devimon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Stephanie Mendez'),
  '2021-05-04'
);

-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Charmander'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Jack Harkness'),
  '2021-02-24'
);

-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Plantmon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Maisy Smith'),
  '2019-12-21'
);

-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Plantmon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'William Tatcher'),
  '2020-08-10'
);

-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Plantmon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Maisy Smith'),
  '2021-04-07'
);

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Squirtle'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Stephanie Mendez'),
  '2019-09-29'
);

-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Angemon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Jack Harkness'),
  '2020-10-03'
);

-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Angemon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Jack Harkness'),
  '2020-11-04'
);

-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Boarmon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Maisy Smith'),
  '2019-01-24'
);

-- Boarmon visited Maisy Smith on May 15th, 2019.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Boarmon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Maisy Smith'),
  '2019-05-15'
);

-- Boarmon visited Maisy Smith on Feb 27th, 2020.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Boarmon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Maisy Smith'),
  '2020-02-27'
);

-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Boarmon'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Maisy Smith'),
  '2020-08-03'
);

-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Blossom'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'Stephanie Mendez'),
  '2020-05-24'
);

-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (animals_id, vets_id, day_of_visit) VALUES (
  (SELECT a.id FROM animals a WHERE name LIKE 'Blossom'),
  (SELECT v.id FROM vets v WHERE v.name LIKE 'William Tatcher'),
  '2021-01-11'
);
