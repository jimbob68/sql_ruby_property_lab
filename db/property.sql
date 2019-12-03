DROP TABLE IF EXISTS propertys_table;

CREATE TABLE propertys_table (
  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  value INT,
  number_of_bedrooms INT,
  year_built INT
);
