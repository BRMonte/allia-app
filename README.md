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
```bash

**List patients**
`GET /v1/patients`
*Returns a paginated list of all patients.*

**Get a specific patient**
`GET /v1/patients/:id`

**Create a patient**
`POST /v1/patients`
*Body params:* `{ "patient": { "name": "string", "email": "string" } }`

---

### Treatment Plans

**List treatment plans**
`GET /v1/treatment_plans`

**Create a treatment plan**
`POST /v1/treatment_plans`
*Body params:* `{ "treatment_plan": { "patient_id": integer, "description": "text" } }`

**Update a treatment plan**
`PATCH/PUT /v1/treatment_plans/:id`

---

### Medication Refill Orders

**List refill orders**
`GET /v1/medication_refill_orders`

**Get refill order details**
`GET /v1/medication_refill_orders/:id`

**Create a refill order**
`POST /v1/medication_refill_orders`
*Body params:* `{ "medication_refill_order": { "treatment_plan_id": integer, "quantity": integer } }`

**Update a refill order**
`PATCH/PUT /v1/medication_refill_orders/:id`

---
