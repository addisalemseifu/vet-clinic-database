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


-- Day 4

-- Create a table named vets with the following columns:

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  date_of_graduation DATE
);


-- There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship.

CREATE TABLE specializations (
  vet_id INTEGER REFERENCES vets(id),
  species_id INTEGER REFERENCES species(id),
  PRIMARY KEY (vet_id, species_id)
);


-- There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.

CREATE TABLE visits (
  vet_id INTEGER REFERENCES vets(id),
  animal_id INTEGER REFERENCES animals(id),
  visit_date DATE,
  PRIMARY KEY (vet_id, animal_id)
);


