SELECT * from animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


BEGIN TRANSACTION;

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;


UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;


BEGIN TRANSACTION;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;


begin transaction;

delete from animals;

select * from animals;

rollback;

select * from animals;


begin

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT my_savepoint;

begin

UPDATE animals
SET weight_kg = weight_kg * -1;

SELECT * FROM animals;

rollback to before_update;

begin

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;

-- QUERIES SELECT AGAIN

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, COUNT(*) AS escape_count
FROM animals
WHERE escape_attempts > 0
GROUP BY neutered
ORDER BY escape_count DESC;

SELECT 
MIN(weight_kg), 
MAX(weight_kg) 
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) from animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT *
FROM animals
WHERE species_id = (SELECT id FROM species WHERE name = 'Pokemon');

SELECT owners.full_name AS owner_name, animals.name AS animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
ORDER BY owners.full_name;

SELECT species.name AS species_name, COUNT(*) AS animal_count
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name AS digimon_name, owners.full_name AS owner_name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name AS animal_name, owners.full_name AS owner_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name AS owner_name, COUNT(animals.id) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(animals.id) DESC
LIMIT 1;

select * from visits
where vet_id = (select id from vets where vets.name = 'William Tatcher')
order by visit_date desc
limit 1;

select count(distinct animal_id) from visits
where vet_id = ( select id from vets where vets.name = 'Stephanie Mendez' );

select vets.name , species.name from specialization
left join species on species.id = specialization.species_id
left join vets on vets.id = specialization.vet_id;

select animals.name from visits
join animals on animals.id = visits.animal_id
where visits.vet_id = ( select id from vets where vets.name = 'Stephanie Mendez' )
and visits.visit_date >= '2020-04-01'
and visits.visit_date <= '2020-08-30';

select animals.name, count(*) as visit_count from visits
join animals on animals.id = visits.animal_id
group by animals.name
order by visit_count
limit 1;

select animals.name , visits.visit_date from visits
join animals on animals.id = visits.animal_id
join vets on vets.id = visits.vet_id
where vets.name = 'Maisy Smith'
order by visits.visit_date
limit 1;

select animals.*, vets.*, visits.visit_date from visits
join animals on animals.id = visits.animal_id
join vets on vets.id = visits.vet_id
order by visits.visit_date desc
limit 1;

select count(*) from visits
join animals on animals.id = visits.animal_id
join vets on vets.id = visits.vet_id
LEFT join specialization on vets.id = specialization.vet_id and animals.species_id = specialization.species_id
where specialization.id IS NULL;

SELECT species.name, COUNT(*) FROM vets
JOIN visits ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;