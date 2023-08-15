USE vet_clinic;
CREATE TABLE animals (
id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
date_of_birth DATE,
escape_attempts INT,
neutered BOOLEAN,
weight_kg DECIMAL
);