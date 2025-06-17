# Case Study: CityCareHub – Smart City Complaint & Resource Management Portal on Azure

## 🌐 Overview

CityCareHub is a cloud-based platform envisioned by a municipal corporation to streamline public service operations such as complaint registration (e.g., garbage pickup delays, streetlight outages), maintenance team tracking, SLA monitoring, and civic resource management. This platform leverages **Microsoft Azure** and **big data tools** to provide:

- ✅ Real-time complaint tracking and SLA monitoring  
- 📊 Dashboards for service performance analytics  
- 👷 Efficient routing and assignment of field staff  
- ☁️ Scalable architecture for smart city needs  

---

## 🚀 Sprint 1 – Database Design and ETL Simulation Using SQL and Python

### 📚 Theme  
Design and implement a normalized relational database to support the operations of a smart city complaint management system. Simulate real-time complaint ingestion and feedback processing using Python.

### 🛠️ Key Tasks Completed

- **Requirement Gathering & Data Modeling**  
  Logical and physical database models were created to represent citizens, complaints, departments, zones, teams, and feedback.

- **Schema Normalization & Constraint Definition**  
  Database tables were normalized and defined with appropriate primary keys, foreign keys, and constraints (e.g., `CHECK`, `NOT NULL`) to ensure data integrity.

- **Table Creation & CRUD Operations**  
  SQL scripts were developed to create the database schema, load sample data, and support Create, Read, Update, and Delete operations for complaint management.

- **Advanced SQL Querying**  
  Analytical queries were developed to calculate:
  - SLA compliance percentages
  - Complaint volume trends by zone and time
  - Team workload distribution

- **Python-Based ETL Simulation**  
  Python scripts were built to:
  - Simulate complaint ingestion from CSV files and randomly generate complaint logs
  - Parse and process citizen feedback data stored in JSON and XML formats

---

## 📦 Deliverables

- 📌 ERD Diagrams and Data Models  
- 🗂️ SQL Scripts for Schema, Constraints, and CRUD Logic  
- 📄 Sample Datasets for Complaints, Citizens, Departments, etc.  
- 🐍 Python Scripts for ETL and Feedback Parsing  
- 📊 SQL Analytical Queries and Sample Outputs  

