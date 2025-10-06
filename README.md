# Top Rated Movies Database - SQL CRUD Operations

A comprehensive SQL project demonstrating CRUD (Create, Read, Update, Delete) operations through a relational database of top-rated movies, directors, actors, and box office data.

## 📋 Table of Contents

- [Overview](#overview)
- [Database Schema](#database-schema)
- [Features](#features)
- [Installation](#installation)
- [CRUD Operations](#crud-operations)
- [Query Examples](#query-examples)
- [Technologies Used](#technologies-used)

## 🎯 Overview

This project showcases fundamental database management skills using MySQL to build and manipulate a movie database. It includes multiple related tables with foreign key constraints, demonstrating normalized database design and complex SQL queries.

## 🗄️ Database Schema

The database consists of five interconnected tables:

### Tables Structure

1. **movies**
   - `movie_id` (PK)
   - `title`
   - `release_year`
   - `genre`
   - `rating`
   - `director_id` (FK)

2. **directors**
   - `director_id` (PK)
   - `name`
   - `birth_year`
   - `nationality`

3. **actors**
   - `actor_id` (PK)
   - `name`
   - `gender`
   - `nationality`

4. **casts**
   - `movie_id` (PK, FK)
   - `actor_id` (PK, FK)
   - `role_name`

5. **box_office**
   - `movie_id` (PK, FK)
   - `domestic_gross`
   - `worldwide_gross`

### Entity Relationship Diagram

```
                    ┌─────────────┐
                    │  DIRECTORS  │
                    └──────┬──────┘
                           │
                           │ directs
                           ↓
                    ┌─────────────┐         ┌─────────────┐
                    │   MOVIES    │────────→│ BOX_OFFICE  │
                    └──────┬──────┘  has    └─────────────┘
                           │
                           │ features
                           ↓
                    ┌─────────────┐
                    │    CASTS    │ (junction table)
                    └──────┬──────┘
                           │
                           │ includes
                           ↓
                    ┌─────────────┐
                    │   ACTORS    │
                    └─────────────┘
```

**Key Relationships:**
- One **director** can direct multiple **movies**
- Each **movie** has one **box office** record
- **Movies** and **actors** have a many-to-many relationship through **casts**

## ✨ Features

- **Normalized Database Design**: Proper table relationships with foreign key constraints
- **Sample Data**: Pre-populated with 10 top-rated movies, 7 directors, and 13 actors
- **Complex Queries**: Multi-table joins and aggregations
- **Data Integrity**: Foreign key constraints ensure referential integrity
- **Real-world Data**: Box office statistics and movie ratings

## 🔧 CRUD Operations

### CREATE

**Creating Tables**: The project demonstrates table creation with proper data types and constraints.

**Inserting Data**: Sample data insertion into all five tables with proper foreign key relationships.

```sql
INSERT INTO directors(director_id, name, birth_year, nationality)
VALUES (101, 'Christopher Nolan', 1970, 'British');
```

### READ

**Simple Two-Table Join**: Retrieves top 3 highest-rated movies with their directors.

**Three-Table Join**: Finds actors and their roles in specific movies.

**Aggregation Query**: Analyzes box office performance with average ratings.

### UPDATE

**Updating Movie Ratings**: Corrects rating data for specific movies.

```sql
UPDATE movies
SET rating = 9.3
WHERE title = 'The Godfather';
```

**Updating Cast Information**: Fixes actor IDs in the cast records.

### DELETE

**Deleting Relationship Records**: Removes cast member from a movie.

```sql
DELETE FROM casts
WHERE movie_id = 7 AND actor_id = 210;
```

**Deleting Primary Entities**: Demonstrates deletion of unlinked records.

## 📊 Query Examples

### Top 3 Highest-Rated Movies with Directors
```sql
SELECT m.title, d.name
FROM movies AS m 
JOIN directors AS d ON m.director_id = d.director_id
ORDER BY m.rating DESC
LIMIT 3;
```

### Cast Information for a Specific Movie
```sql
SELECT m.title AS movie_title, a.name AS actor, c.role_name 
FROM movies AS m
JOIN casts AS c ON m.movie_id = c.movie_id
JOIN actors AS a ON c.actor_id = a.actor_id
WHERE m.title = 'Inception';
```

### Top 5 Movies by Box Office Performance
```sql
SELECT m.title, 
       ROUND(AVG(m.rating), 1) AS avg_rating,
       ROUND(AVG(b.worldwide_gross)) AS avg_worldwide_gross
FROM movies AS m
JOIN box_office AS b ON m.movie_id = b.movie_id
GROUP BY m.title
ORDER BY avg_worldwide_gross DESC, avg_rating DESC
LIMIT 5;
```

## 💻 Technologies Used

- **MySQL**: Relational Database Management System
- **SQL**: Structured Query Language for database operations
- **Visual Studio Code**: Code editor for writing and managing SQL scripts
- **MySQL Workbench**: Database design and administration tool (optional)

## 📝 Key Learning Outcomes

- Database design and normalization
- Primary and foreign key constraints
- Complex SQL joins (INNER JOIN)
- Data aggregation and grouping
- CRUD operations implementation
- Data integrity and referential constraints

---

⭐ If you found this project helpful, please give it a star!