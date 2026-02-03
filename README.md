# Patient Treatment Plans API

Simple Rails API for managing patients, treatment plans, and medication refill orders.

---

## Gems

- `kaminari` – pagination
- `active_model_serializers` – JSON serialization
- `pg` – PostgreSQL adapter
- `rspec-rails` – testing
- `factory_bot_rails` – test data

## Setup

```bash
bundle install
rails db:create db:migrate
rails db:seed

## API Usage

Base URL: `/v1`

### Patients

**List patients**
```http
GET /v1/patients
