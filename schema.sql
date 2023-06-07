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
