# 📦 infra-database

This directory manages the **PostgreSQL database** for the project using versioned migrations powered by **Flyway**, completely decoupled from the main application.

> This follows the **infra-driven migrations** (aka **externalized Flyway execution**) approach, where Flyway is run outside the application via Docker Compose — ensuring full control, clarity, and reproducibility in database versioning.

---

## 📁 Structure

```text
infra-database/
├── docker-compose-database.yml     # Spins up the PostgreSQL container
├── docker-compose-flyway.yml       # Runs Flyway migrations in a separate container
├── scripts/                        # Flyway versioned SQL scripts (V1, V2, ...)
└── .env                            # Environment variables for DB connection
```

---

## 🚀 How to use

### 💻 Run Locally (Database + Migrations)

To run the database environment locally with migrations in detached mode:

```bash
docker-compose --env-file .env -f docker-compose-database.yml -f docker-compose-flyway.yml up -d
```

or if you want to run it in the foreground:

```bash
docker-compose --env-file .env -f docker-compose-database.yml -f docker-compose-flyway.yml up
```

---

## 📄 `.env` example

```env
DB_URL=jdbc:postgresql://postgresql:5432/DATABASE_NAME
DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=DATABASE_NAME
```

> Make sure to adjust the values based on your environment.

---

## 🧠 Why this approach?

- Keeps migration logic **fully isolated**
- Easier to **audit**, **reproduce**, and **control**
- Ideal for use in **CI/CD pipelines**
- Enables migration execution without relying on the Spring Boot lifecycle

---

## 🛠 Notes

- Migration scripts should follow the naming pattern:
  - `V1__create_tables.sql`
  - `V2__insert_initial_data.sql`
  - ...
- All scripts placed in the `scripts/` folder will be automatically detected and executed by the Flyway container.
- The Flyway image runs migrations immediately upon container startup.

---

Made with ❤️ by [Kaique](https://github.com/kbdemiranda)