# Movie Database System   

## Overview  
This project is a **scalable movie database system** developed for a streaming platform using **ASP.NET** and **PostgreSQL**. It is designed to support millions of users and movies, optimized for performance and scalability, with features enabling recommendations and analytics.

---

## Key Features  
- **Optimized Query Performance**  
  - Implemented **secondary indexing** for fields like `genre` and `director` to improve search and filter speeds.  
  - Utilized **materialized views** for precomputed data, such as top-rated movies by genre, reducing query load.  

- **Partitioned Database Design**  
  - Partitioned tables to handle large datasets efficiently.  
  - Dynamic data insertion supported via a **REST API**, ensuring smooth database interactions.  

- **Scalability & Analytics**  
  - Designed for handling millions of records with high performance.  
  - Enables advanced analytics, including recommendations and trends.  

---

## Technologies Used  
- **Backend**: ASP.NET (C#)  
- **Database**: PostgreSQL with secondary indexing, materialized views, and partitioning.  
- **API**: REST API for CRUD operations and seamless database interaction.  
