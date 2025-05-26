1. **What is PostgreSQL**?

- PostgreSQL is a powerful open source object-relational database management system (ORDBMS). It is known for its standards compliance and extensibility. Postgres supports advance features such as,
  - Complex Queries,
  - Foreign keys, triggers, views,
  - Stored Procedures,
  - Full-text search,
  - JSON/JSONB (for semi-structured Data).

2. **What is the purpose of a database schema in PostgreSQL?**
   - A schema in Postgres is a logical container within a database. It helps in organizing database objects like tables, views, indexes, functions, sequences etc, Schemas are especially useful when you want to:
     - Group related Table logically.
     - Avoid name conflicts.
     - Manage access control and user permissions more cleanly.

```javascript
CREATE SCHEMA wildlife;
CREATE TABLE wildlife.rangers (
  ranger_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
)
```

- This `CREATE SCHEMA wildlife` create a new schema named wildlife. It's like a folder within the database where we can group related objects together, like tables and functions. This way helps in managing database better especially in larger applications.

3. Explain the **Primary Key** and **Foreign Key** concepts in PostgreSQL.
   - PRIMARY KEY : Uniquely identifies each row in a table. It cannot be null or duplicated.
   - FOREIGN KEY : Establishes a relationship between two tables. It references a column in another table (usually the primary key).

```javascript
  CREATE TABLE species(
    species_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
  );

  CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    species_id INT PREFERENCES species(species_id),
    location VARCHAR(100)
  );

```

    - In this example, each sighting is linked to a species using reference of `species_id`, which is a foreign key on sighting table, Basically it was primary key on species table.

4. What is the difference between the `VARCHAR` and `CHAR` data types?
   - `CHAR(n)` : Fixed-length character type. If the input is shorter than `n`, it's padded with spaces.

```javascript
  CREATE TABLE species(
    name CHAR(8)
  )
  INSERT INTO species values('Lion') //'Lion    ' with extra 4 spaces
```

`Lion` is 4 characters so it will fill left 4 characters with 4 spaces

- `VARCHAR(n)` : Variable-length character type. It only uses as much space as needed (up to `n` characters).

```javascript
  CREATE TABLE species(
    name VARCHAR(8)
  )
  INSERT INTO species values('Lion') //'Lion' without extra spaces
```

`Lion` is 4 characters and there won't be any spaces.

5. **Explain the purpose of the `WHERE` clause in a `SELECT` statement.**

- The `WHERE` clause is used to filter records that meet certain conditions. Without it, a query would turn all rows in a table.

```javascript
SELECT * FROM sightings WHERE location ILIKE '%pass';
//It returns only those locations end with "pass" from 'sightings' table...
```

6. **What are the `LIMIT` and `OFFSET` clauses used for?**
   - `LIMIT` restricts the number of rows returned.
   - `OFFSET` skips a specific number of rows before beginning to return rows.
     basically they are very useful for pagination, and to get a limited data from a table...

```javascript
SELECT * FROM sightings ORDER BY sighting_time DESC LIMIT 5 OFFSET 10;
```

Here `OFFSET 10 will skip first 10 rows and then will return 5 most recent sightings rows`

7. **How can you modify data using `UPDATE` statements?**
   - `UPDATE` is used to change existing records in a table. It is often combine with `WHERE` to target specific rows.

```javascript
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';
// Changes the status of 'species' table where species were discovered before 1800 to 'Historic'...
```

8. **What is the significance of the `JOIN` operation, and how does it work in PostgreSQL?**
   - `JOIN` is used to combine two or more tables based on related columns (usually foreign keys).
   ```javascript
     SELECT sp.common_name, s.sighting_time, r.name
     FROM sightings s
     JOIN species sp ON s.species_id = sp.species_id
     JOIN rangers r ON s.ranger_id = r.ranger_id
     ORDER BY s.sighting_time DESC LIMIT 2;
   ```
   - **Types of Joins :**
     - `INNER JOIN` - only rows with matches in both tables.
     - `LEFT JOIN` - all rows from the left table + matched rows from the right.
       ```javascript
         SELECT r.name, COUNT(s.sighting_id) AS total_sightings
         FROM rangers r
         LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
         GROUP BY r.ranger_id, r.name
         ORDER BY r.name;
       ```
     - `RIGHT JOIN` - all rows from the right + matched rows from the left.
     - `FULL JOIN` - all rows from both tables.
9. **Explain the `GROUP BY` clause and its role in aggregation operations.**
   - `GROUP BY` groups rows that have the same values into summary rows, often used with aggregate functions like `COUNT()`, `SUM()`,`AVG()` etc . . .
   ```javascript
   SELECT ranger_id, COUNT(*) AS total_sightings
   FROM sightings
   GROUP BY ranger_id;
   //Counts how many sightings each ranger has made...
   ```
10. **How can you calculate aggregate functions like `COUNT()`, `SUM()`, and `AVG()` in PostgreSQL?**
    - Aggregate functions perform calculations across multiple rows and returns a single value . . .
      - `COUNT()` - Number of rows
        ```javascript
        SELECT COUNT(*) FROM species; //Total number of Species
        ```
      - `SUM()` - Total value
      - `AVG()` - Average value
        ```javascript
          SELECT AVG(sighting_count) AS average_sightings_per_ranger
          FROM (
            SELECT ranger_id, COUNT(*) AS sighting_count
            FROM sightings
            GROUP BY ranger_id
          ) AS ranger_sightings; //This subquery inside aggregation shows the average of  sightings...
        ```
      - `MAX()`/`MIN()` - Highest / Lowest
        ```javascript
          SELECT MAX(sighting_time) FROM sightings; //most recent sighting_time
        ```
