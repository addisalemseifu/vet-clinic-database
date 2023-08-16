USE vet_clinic;
CREATE TABLE animals (
id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
date_of_birth DATE,
escape_attempts INT,
neutered BOOLEAN,
weight_kg DECIMAL
);


-- Day two

ALTER TABLE animals
ADD species VARCHAR(255);

-- Day three

-- Create a table named owners with the following columns:
CREATE TABLE owners (
id SERIAL PRIMARY KEY,
full_name VARCHAR(255) NOT NULL,
age INT
);

-- Create a table named species with the following columns:

CREATE TABLE species(
id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL
);

-- Day 3

-- Remove column species

ALTER TABLE animals DROP column species;

-- Add column species_id which is a foreign key referencing species table

ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table

ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);
