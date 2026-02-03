# Patient Treatment Plans API

Simple Rails API for managing patients, treatment plans, and medication refill orders.

---

## Gems

- `kaminari` – pagination
- `active_model_serializers` – JSON serialization
- `pg` – PostgreSQL adapter
- `puma` – app server
- `bootsnap` – boot performance
- `rspec-rails` – testing
- `factory_bot_rails` – test data
- `rubocop-rails-omakase` – linting
- `brakeman` – security scanning

## Setup

```bash
bundle install
rails db:create db:migrate
rails db:seed
