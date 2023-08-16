-- Find all animals whose name ends in "mon".
SELECT * FROM animals
WHERE name LIKE '%mon%';

-- List the name of all animals born between 2016 and 2019.

SELECT name FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

-- List the name of all animals that are neutered and have less than 3 escape attempts.

SELECT name FROM animals
WHERE neutered IS TRUE AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".

SELECT date_of_birth FROM animals
WHERE name = 'Pikachu' OR name = 'Augmon';

-- List name and escape attempts of animals that weigh more than 10.5kg

SELECT name,escape_attempts FROM animals
WHERE weight_kg > 10.5;

-- Find all animals that are neutered.

SELECT * FROM animals
WHERE neutered IS TRUE;

-- Find all animals not named Gabumon.

SELECT * FROM animals
WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)

SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- Day 2

-- Update the animals table and then roll back

BEGIN;
UPDATE animals SET species = NULL;
ROLLBACK;


BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species = NULL;

COMMIT;

--  Inside a transaction delete all records in the animals table, then roll back the transaction.

BEGIN;
DELETE FROM animals
ROLLBACK;

-- Delete all animals born after Jan 1st, 2022.

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01'

-- Create a savepoint for the transaction.

SAVEPOINT sv1;

--Update all animals' weight to be their weight multiplied by -1.

UPDATE animals SET weight_kg = weight_kg * '-1';

-- Rollback to the savepoint

ROLLBACK TO SV1;

-- Update all animals' weights that are negative to be their weight multiplied by -1.

UPDATE animals SET weight_kg = weight_kg * '-1'
WHERE weight_kg < 0;

-- Commit transaction

COMMIT;

-- How many animals are there?

SELECT COUNT(name) FROM animals;

-- How many animals have never tried to escape?

SELECT COUNT(escape_attempts) FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?

SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?

SELECT
    AVG(escape_attempts)
FROM
    animals
GROUP BY neutered

-- What is the minimum and maximum weight of each type of animal?

SELECT
    MAX(weight_kg), MIN(weight_kg)
FROM
    animals
GROUP BY  species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT
    date_of_birth, AVG(escape_attempts)
FROM
    animals
GROUP BY species, date_of_birth
HAVING date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'


-- Day 3

-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?

SELECT name
FROM animals
JOIN owners
ON animals.owner_id = 4;

-- List of all animals that are pokemon (their type is Pokemon).

SELECT animals.name
FROM animals
JOIN species
ON animals.species_id = 1;

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT animals.name,owners.full_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?

SELECT species.name, COUNT(animals.id) AS num_animals
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell'

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?

SELECT owners.full_name, COUNT(animals.id) AS num_animals
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY num_animals DESC
LIMIT 1;

