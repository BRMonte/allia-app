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

This is the answer to the questions made:

To scale this system to around 100k patients and10M medication refill orders per month, I’d start with fundamentals before adding complexity. The biggest win is at the DB level: proper indexing on FKs, filter fields, and timestamps, combined with strict pagination on all list endpoints so queries never scan large tables. 

Reads and writes would be separated as traffic grows, with read replicas handling list and show endpoints while writes stay on the primary. At that scale, I’d also keep serializers flat and avoid loading associations unless explicitly needed, which keeps query counts predictable and memory usage low.

For production readiness, the first change would be adding observability: structured logs, request-level metrics, and basic dashboards so we can actually see how the system behaves under load. 

Second, I’d tighten validation and error handling around edge cases and invalid states, especially for status transitions, to avoid bad data entering the system. Third, I’d introduce simple caching for read-heavy endpoints like fetching patients or treatment plans, using short TTLs and explicit invalidation on writes — nothing fancy, just enough to reduce repeated database hits.

In terms of metrics and logs, I’d track request latency per endpoint, 5xx error rate, and DB query time vs. total request time. On the business side, I’d also track counts of created refill orders and status transitions to spot anomalies. 
Logs should be structured and correlated by request ID so a single failing request can be traced across the stack.
To detect 5xx spikes and slow endpoints, I’d rely on alerts based on thresholds and trends rather than single failures. For example, an alert when the 5xx rate goes above a small percentage over a rolling window.

For security, given this is health-related data, I’d treat everything as sensitive by default. All data must be encrypted in transit and at rest, access should be authenticated and authorized even for internal services, and logs must never contain personal or medical information. I’d also limit exposure by returning only the fields needed by each endpoint and enforcing least-privilege access at the database and infrastructure level. Auditing access to patient-related data is important too, especially as the system grows and more services or people interact with it.

Overall, the goal is to keep the system boring, observable, and predictable first and only add complexity when real usage justifies it.

