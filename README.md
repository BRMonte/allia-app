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
```

---

## API Usage

**Base URL:** `/v1`  
**Pagination:** All index endpoints use `kaminari` (default: 20 records per page). Use `?page=N` to navigate.

### 1. Patients

**List patients**
`GET /v1/patients`

**Get a specific patient**
`GET /v1/patients/:id`

**Create a patient**
`POST /v1/patients`

```bash
curl -X POST http://localhost:3000/v1/patients \
-H "Content-Type: application/json" \
-d '{
  "patient": {
    "first_name": "John",
    "last_name": "Doe",
    "email": "john.doe@example.com",
    "date_of_birth": "1990-01-01"
  }
}'
```

---

### 2. Treatment Plans

**List treatment plans**
`GET /v1/treatment_plans?patient_id=1`
*Filter by `patient_id` is supported.*

**Create a treatment plan**
`POST /v1/treatment_plans`

```bash
curl -X POST http://localhost:3000/v1/treatment_plans \
-H "Content-Type: application/json" \
-d '{
  "treatment_plan": {
    "patient_id": 1,
    "name": "Physiotherapy Plan",
    "status": "active",
    "start_date": "2023-01-01",
    "end_date": "2023-06-01"
  }
}'
```

**Update treatment plan status**
`PATCH/PUT /v1/treatment_plans/:id`

```bash
curl -X PATCH http://localhost:3000/v1/treatment_plans/1 \
-H "Content-Type: application/json" \
-d '{ "status": "completed" }'
```

---

### 3. Medication Refill Orders

**List refill orders**
`GET /v1/medication_refill_orders`
*Filters: `treatment_plan_id`, `status`, `requested_date`.*

**Get refill order details**
`GET /v1/medication_refill_orders/:id`

**Create a refill order**
`POST /v1/medication_refill_orders`

```bash
curl -X POST http://localhost:3000/v1/medication_refill_orders \
-H "Content-Type: application/json" \
-d '{
  "medication_refill_order": {
    "treatment_plan_id": 1,
    "requested_date": "2023-10-27",
    "status": "pending"
  }
}'
```

**Update refill order status**
`PATCH/PUT /v1/medication_refill_orders/:id`

```bash
curl -X PATCH http://localhost:3000/v1/medication_refill_orders/1 \
-H "Content-Type: application/json" \
-d '{ "status": "shipped" }'
```

---
