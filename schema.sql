CREATE TABLE animals (
    id int PRIMARY KEY NOT NULL,
    name varchar(40) NOT NULL,
    date_of_birth date NOT NULL,
	escape_attempts int NOT NULL,
    neutered boolean,
    weight_kg decimal
);
