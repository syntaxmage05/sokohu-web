# SokoHub Web

SokoHub Web is a Ruby on Rails marketplace application for posting listings, browsing a live feed, saving items, and chatting between buyers and sellers. The application is optimized for server-rendered performance with Hotwire, background jobs with Sidekiq, and PostgreSQL-backed data models.

## What the project does

- **Marketplace listings** with title, price, condition, tags, photos, rich text descriptions, and address information.
- **Publishing workflow** with draft, published, and expired listing states.
- **Discovery tools** through feed search and tag filtering.
- **Buyer engagement** through saved listings and direct conversations/messages.
- **User account system** with sign up, login/logout, profile management, and password reset flows.

## Tech stack

### Backend
- Ruby on Rails 8
- PostgreSQL
- Sidekiq + sidekiq-cron for async/background processing
- Active Storage and Action Text

### Frontend
- Hotwire (Turbo + Stimulus)
- Bulma CSS
- ESBuild + Sass via jsbundling-rails/cssbundling-rails

### Tooling
- Minitest + Capybara/Selenium for tests
- RuboCop (Rails Omakase)
- Brakeman for security scanning

## Core domain model (high level)

- `User` owns memberships and can save listings.
- `Organization` groups activity and participates in conversations.
- `Listing` belongs to an organization + creator, has statuses and listing metadata.
- `Conversation` links a buyer/seller pair around a listing.
- `Message` records chat messages inside a conversation.

## Main application routes

- `/` — listing feed
- `/sign_up`, `/login`, `/logout` — authentication
- `/profile` — account profile
- `/listings/*` — create/edit/show listings, save listing, contact listing owner
- `/my_listings` and `/saved_listings` — user views
- `/search` and `/search/tags/:tag` — search/filter
- `/conversations` and nested `/messages` — marketplace messaging
- `/sidekiq` — Sidekiq dashboard

## Getting started

### 1) Prerequisites
Install the following locally:

- Ruby (see `.ruby-version`)
- Bundler
- PostgreSQL
- Node.js + Yarn (see `.node-version`)
- Redis (required by Sidekiq)

### 2) Install dependencies

```bash
bundle install
yarn install
```

### 3) Set up the database

```bash
bin/rails db:prepare
```

### 4) Run the app in development

```bash
bin/dev
```

This starts:
- Rails web server
- JS watcher (`yarn build --watch`)
- CSS watcher (`yarn build:css --watch`)
- Sidekiq worker

### 5) (Optional) Seed data

```bash
bin/rails db:seed
```

## Useful development commands

```bash
# Run test suite
bin/rails test

# Lint Ruby code
bin/rubocop

# Security scan
bin/brakeman

# Run sidekiq manually
bundle exec sidekiq
```

## Background jobs and schedules

- Sidekiq is configured via `config/sidekiq.yml`.
- A recurring job is configured in `config/schedule.yml` to purge unattached Active Storage blobs daily.

## Deployment

The repository includes a `render.yaml` for Render deployment:

- Web service name: `sokohub`
- Build command: `./bin/render-build.sh`
- Start command: `./bin/rails server`
- Managed Postgres database and required `RAILS_MASTER_KEY` environment variable

## Project structure (quick map)

- `app/models` — domain models and policies/concerns
- `app/controllers` — web and API-like request handlers
- `app/views` — server-rendered templates
- `app/javascript` — Stimulus controllers and client-side helpers
- `config` — framework, routes, Sidekiq, database, and schedules
- `db` — schema + seeds

## Notes

- Letter Opener is mounted in development for email previewing.
- Mobile-specific templates are supported for select views.

---
If you want, I can also generate a shorter **public/open-source README** variant and a separate **CONTRIBUTING.md** for onboarding new contributors.
