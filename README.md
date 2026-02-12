# FreeDoc - The Medical Booking System (Rails Edition)

![Ruby](https://img.shields.io/badge/Ruby-3.4.2-red) ![Rails](https://img.shields.io/badge/Rails-8.1.2-red) ![Gems](https://img.shields.io/badge/Gems-Faker-blue)

Welcome to **FreeDoc**, a database-centric project created as part of **The Hacking Project (THP)** bootcamp. The goal is to master **ActiveRecord** and complex database relationships (1-N and N-N) by building a functional backend clone of a medical appointment platform like Doctolib.

## Prerequisites

- **Ruby** (version 3.4.2)
- **Rails** (version 8.1.x)
- **Gems**: `faker` (for generating seed data)

## Database Architecture

This project implements a relational schema to manage doctors, patients, and their interactions across cities.

![FreeDoc ERD](FreeDoc.png)

*Entity-relationship diagram: see `FreeDoc.png`.*

### Entities and Attributes (ERD)

| Table                         | Attributes                                           |
| ----------------------------- | ---------------------------------------------------- |
| **CITY**                      | `name` (string)                                      |
| **DOCTOR**                    | `first_name`, `last_name`, `zip_code` (string), `city_id` (FK) |
| **PATIENT**                   | `first_name`, `last_name` (string), `city_id` (FK)   |
| **SPECIALTY**                 | `name` (string)                                      |
| **APPOINTMENT**               | `date` (datetime), `doctor_id`, `patient_id`, `city_id` (FK) |
| **JOIN_TABLE_DOCTOR_SPECIALTY** | `doctor_id`, `specialty_id` (FK)                    |

Rails automatically adds `id` (PK) and `created_at` / `updated_at` to each table.

### Relationships (ERD)

- **CITY** → 1-N → DOCTOR, PATIENT, APPOINTMENT
- **DOCTOR** ↔ N-N ↔ SPECIALTY via JOIN_TABLE_DOCTOR_SPECIALTY
- **DOCTOR** → 1-N → APPOINTMENT ; **PATIENT** → 1-N → APPOINTMENT (N-N Doctor–Patient via Appointment)

### Model Relationships (code)

- **City**: Central hub. Doctors, Patients, and Appointments belong to a City.
- **Doctor**: Belongs to city. Has many appointments and patients (through appointments). Has many specialties (through JoinTableDoctorSpecialty).
- **Patient**: Belongs to city. Has many appointments and doctors (through appointments).
- **Specialty**: Has many doctors (through JoinTableDoctorSpecialty).
- **Appointment**: Belongs to doctor, patient, and city (join between doctor and patient with date and location).

## Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/ValVoy/THP---FreeDoc-Project.git
   cd THP---FreeDoc-Project
   ```

2. **Install dependencies**:

   ```bash
   bundle install
   ```

3. **Setup the database**:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Seed the database**:

   ```bash
   rails db:seed
   ```

   This populates the database with 10 cities, 7 specialties, 20 doctors, 50 patients, and 100 appointments using the Faker gem.

## Usage & Testing

This is a backend-only project; verifications are done via the **Rails Console**.

```bash
rails console
```

### Useful commands to test associations

- Doctor's specialties (N-N):

  ```ruby
  Doctor.first.specialties
  ```

- Doctor's patients (N-N through appointments):

  ```ruby
  Doctor.first.patients
  ```

- City relationships (1-N):

  ```ruby
  City.first.doctors
  City.first.patients
  ```

- Doctor for an appointment:

  ```ruby
  Appointment.last.doctor
  ```

## Key concepts

### 1. Advanced ActiveRecord associations

- **has_many :through**: Doctors and Patients are linked via Appointments (e.g. `doctor.patients`).
- **Join table**: JoinTableDoctorSpecialty links Doctors and Specialties so a doctor can have several specialties.

### 2. Database migrations

- Tables created in dependency order (cities before doctors/patients, etc.).
- Use of `t.references` with `foreign_key: true` for foreign keys.

### 3. Data integrity & seeding

- `seeds.rb` creates records in a valid order and uses Faker and `.sample` for realistic data. Destroy order respects foreign keys.

## Related projects (THP BDD)

- [The Gossip Project](https://github.com/DevRedious/gossip-project) — Gossips, tags, comments, likes, private messages (polymorphic associations).
- [DogBnB](https://github.com/ff14eternitalis-debug/dogbnb) — Dog rental platform (N-N through Strolls).

## Authors

This project is for educational use within The Hacking Project. Feel free to modify or improve it in your own fork.

Morgan, Romain & Valentin

_The Hacking Project 2026_
