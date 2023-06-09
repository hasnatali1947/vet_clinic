CREATE TABLE animals (
    id int PRIMARY KEY NOT NULL,
    name varchar(40) NOT NULL,
    date_of_birth date NOT NULL,
	escape_attempts int NOT NULL,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

CREATE TABLE owners (
	id serial primary key,
	full_name varchar(100),
	age integer
);
create table species(
	id serial PRIMARY KEY,
	name varchar
);

ALTER TABLE animals
DROP COLUMN species,
ADD COLUMN species_id int REFERENCES species(id),
ADD COLUMN owner_id int REFERENCES owners(id);

create table vets (
    id serial primary key,
    name varchar(100),
    age int,
    date_of_graduation date 
);

create table specialization (
    vet_id int,
    species_id int,
    foreign key (vet_id) references vets(id),
    foreign key (species_id) references species(id)
);

create table visits (
    animal_id int,
    vet_id int,
    visit_date date,
    foreign key (animal_id) references animals(id),
    foreign key (vet_id) references vets(id)
);
