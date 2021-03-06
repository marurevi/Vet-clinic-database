/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY (id)
);

/* SECOND PULL REQUEST */

ALTER TABLE animals
ADD species VARCHAR(50);

BEGIN TRANSACTION;
UPDATE animals
SET species= 'unspecified';
ROLLBACK;

BEGIN TRANSACTION;
UPDATE animals
SET species= 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species= 'pokemon'
WHERE species ISNULL;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg= weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg= weight_kg* -1 WHERE weight_kg < 0;
COMMIT TRANSACTION;

/* THIRD PULL REQUEST */

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(50),
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    PRIMARY KEY (id)
);

-- Modify animals table:
--Remove column species
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id INT, 
ADD FOREIGN KEY(species_id) REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals 
ADD COLUMN owner_id INT, 
ADD FOREIGN KEY(owner_id) REFERENCES owners(id);

/* FOURTH PULL REQUEST */

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

-- Join Tables:

CREATE TABLE specializations (
    vets_id INT,
    species_id INT,
    FOREIGN KEY (vets_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

CREATE TABLE visits (
    animals_id INT,
    vets_id INT,
    day_of_visit DATE,
    FOREIGN KEY (animals_id) REFERENCES animals(id),
    FOREIGN KEY (vets_id) REFERENCES vets(id)
);

--Modify owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- CREATE INDEXES
CREATE INDEX ON visits (animals_id);

CREATE INDEX ON visits (vets_id);

CREATE INDEX ON owners (email);

