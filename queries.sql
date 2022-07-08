/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT * FROM animals WHERE '2016-01-01' <= date_of_birth AND date_of_birth <= '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT  date_of_birth , name FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg.
SELECT name , escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name <> 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE 10.4 <= weight_kg AND weight_kg <= 17.3;

///* SECOND PULL REQUEST *///

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts= 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS WhoEscapeMost FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS minWgth, MAX(weight_kg) AS maxWgth FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* THIRD PULL REQUEST */
-- What animals belong to Melody Pond?
SELECT name FROM animals JOIN owners ON owner_id = owners.id 
WHERE owners.id = (SELECT id FROM owners WHERE full_name LIKE 'Melody Pond' );

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON species_id = species.id 
WHERE species.id = (SELECT id FROM species WHERE species.name LIKE 'Pokemon' );

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT COUNT(animals.name), species.name FROM animals JOIN species ON species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT name AS digimon 
FROM (
    SELECT animals.name, animals.owner_id 
    FROM animals JOIN SPECIES ON species_id = species.id 
    WHERE species.name LIKE 'Digimon'
    ) AS digimonList 
JOIN owners ON digimonList.owner_id = owners.id 
WHERE owners.full_name LIKE 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name FROM animals JOIN owners 
ON animals.owner_id = (
    SELECT id FROM owners WHERE full_name LIKE 'Dean Winchester'
) WHERE animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT COUNT(animals.name) AS number_pkmns, owners.full_name 
FROM animals JOIN owners ON animals.owner_id = owners.id 
GROUP BY owners.full_name
ORDER BY number_pkmns DESC LIMIT 1;

-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT a.name, v.day_of_visit FROM animals a JOIN visits v ON a.id = v.animals_id 
WHERE v.vets_id = (
  SELECT id FROM vets WHERE vets.name LIKE 'William Tatcher'
) ORDER BY v.day_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT a.name) FROM animals a JOIN visits v ON a.id = v.animals_id 
WHERE v.vets_id = (
  SELECT id FROM vets WHERE vets.name LIKE 'Stephanie Mendez'
)
-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, s.name AS speciality FROM vets v LEFT JOIN (
    SELECT s.name, sp.vets_id AS id FROM species s JOIN specializations sp ON sp.species_id = s.id
) AS s ON v.id = s.id GROUP BY v.name, speciality;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name, b.day_of_visit FROM (
    SELECT a.name, a.id FROM animals a JOIN visits v ON a.id = v.animals_id GROUP BY a.name, a.id
) AS a JOIN visits b ON b.vets_id = (SELECT id FROM vets WHERE vets.name LIKE 'Stephanie Mendez') 
WHERE b.day_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT COUNT(*) AS how_many, name_pkm FROM (
    SELECT a.name FROM animals a JOIN visits v ON a.id = v.animals_id
) AS name_pkm GROUP BY name_pkm
ORDER BY how_many DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name, v.day_of_visit FROM animals a JOIN visits v ON a.id = v.animals_id 
WHERE v.vets_id = (SELECT id FROM vets WHERE name LIKE 'Maisy Smith')
ORDER BY v.day_of_visit ASC LIMIT 1

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT v.day_of_visit, a.*, b.*
FROM visits v
FULL OUTER JOIN animals a ON a.id = v.animals_id
FULL OUTER JOIN vets b ON b.id = v.vets_id
ORDER BY v.day_of_visit ASC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT SUM(count) AS how_many FROM (
SELECT COUNT(distinct v.day_of_visit) FROM visits v
JOIN animals a ON v.animals_id = a.id
LEFT JOIN specializations AS sp ON v.vets_id = sp.vets_id
WHERE a.species_id <> sp.species_id 
AND v.vets_id <> (SELECT id FROM vets WHERE name LIKE 'Stephanie Mendez')
UNION ALL
SELECT COUNT(v.day_of_visit) FROM visits v
JOIN animals a ON v.animals_id = a.id
LEFT JOIN specializations AS sp ON v.vets_id = sp.vets_id
WHERE sp.species_id ISNULL
) AS MyNewTable

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name, COUNT(*) FROM visits v 
JOIN animals a ON v.animals_id = a.id 
JOIN vets b ON v.vets_id = b.id
JOIN species s ON a.species_id = s.id 
WHERE v.vets_id = (SELECT id FROM vets WHERE name LIKE 'Maisy Smith')
GROUP BY s.name;
