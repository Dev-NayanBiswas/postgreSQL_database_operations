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
4. What is the difference between the `VARCHAR` and `CHAR` data types?
5. Explain the purpose of the `WHERE` clause in a `SELECT` statement.
6. What are the `LIMIT` and `OFFSET` clauses used for?
7. How can you modify data using `UPDATE` statements?
8. What is the significance of the `JOIN` operation, and how does it work in PostgreSQL?
9. Explain the `GROUP BY` clause and its role in aggregation operations.
10. How can you calculate aggregate functions like `COUNT()`, `SUM()`, and `AVG()` in PostgreSQL?
