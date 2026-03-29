# BugTrackr (Rails)

> A Jira/Trello-style issue tracker and Kanban project management system — built with Ruby on Rails. Real-time boards, role-based access, and a clean RESTful API.

![Ruby](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=flat&logo=rubyonrails&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white)
![ActionCable](https://img.shields.io/badge/ActionCable-WebSockets-blueviolet?style=flat)
![License](https://img.shields.io/badge/license-MIT-green?style=flat)

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔐 JWT Authentication | Stateless token auth with secure refresh rotation |
| 👥 Team RBAC | Owner, manager, developer, viewer roles via Pundit |
| ⚡ Real-time Board | Live Kanban updates over ActionCable WebSockets |
| 🗂️ Kanban Columns | Customizable columns per project, drag-to-move issues |
| 🐞 Issue Tracking | Priority, assignee, due date, and status per issue |
| 📎 File Attachments | Uploads via ActiveStorage with S3 support |
| 💬 Comments | Threaded comments on every issue |
| 🔔 Notifications | Assignment and update alerts via Sidekiq background jobs |
| 🧭 RESTful API | Clean, versioned JSON API with consistent error handling |

---

## 🧱 Tech Stack

| Technology | Role | Version |
|---|---|---|
| Ruby on Rails (API mode) | Core framework | 7.x |
| PostgreSQL | Primary database | 15 |
| JWT | Stateless authentication | gem |
| Pundit | Authorization policies | gem |
| ActiveStorage | File attachment handling | built-in |
| ActionCable | Real-time WebSocket updates | built-in |
| Sidekiq + Redis | Background job processing | gem |

---

## 🗄️ Data Models

```
User
  ├── id (PK)
  ├── email
  ├── password_digest
  └── name

Team
  ├── id (PK)
  ├── name
  └── slug

TeamMember
  ├── id (PK)
  ├── user_id (FK → User)
  ├── team_id (FK → Team)
  └── role  [owner | manager | developer | viewer]

Project
  ├── id (PK)
  ├── team_id (FK → Team)
  ├── name
  └── description

Column
  ├── id (PK)
  ├── project_id (FK → Project)
  ├── name
  └── position

Issue
  ├── id (PK)
  ├── column_id (FK → Column)
  ├── assignee_id (FK → User)
  ├── title
  ├── description
  ├── priority  [low | medium | high]
  └── due_date

Comment
  ├── id (PK)
  ├── issue_id (FK → Issue)
  ├── user_id (FK → User)
  └── body

Attachment
  ├── id (PK)
  └── issue_id (FK → Issue)

Notification
  ├── id (PK)
  ├── user_id (FK → User)
  ├── notifiable (polymorphic)
  └── read_at
```

---

## 🚀 Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/your-username/bugtrackr-rails.git
cd bugtrackr-rails
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Configure environment

```bash
cp .env.example .env
# Set the following in .env:
#   DATABASE_URL=postgres://localhost/bugtrackr_dev
#   JWT_SECRET=your_secret_here
#   REDIS_URL=redis://localhost:6379
```

### 4. Set up the database

```bash
rails db:create db:migrate db:seed
```

### 5. Start background jobs (separate tab)

```bash
bundle exec sidekiq
```

### 6. Start the server

```bash
rails s
# → http://localhost:3000
```

---

## 🔌 API Endpoints

### Authentication

| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/auth/register` | Register a new user |
| `POST` | `/auth/login` | Authenticate & receive JWT |
| `POST` | `/auth/refresh` | Rotate refresh token |

### Teams & Projects

| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/teams` | Create a team |
| `GET` | `/teams/:id` | Get team details |
| `POST` | `/teams/:id/members` | Invite member with role |
| `PATCH` | `/teams/:id/members/:user_id` | Update member role |
| `POST` | `/projects` | Create project in team |
| `GET` | `/projects/:id/board` | Fetch full Kanban board |

### Issues

| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/issues` | Create issue |
| `GET` | `/issues/:id` | Get issue detail |
| `PATCH` | `/issues/:id` | Update issue |
| `PATCH` | `/issues/:id/move` | Move issue to column |
| `DELETE` | `/issues/:id` | Delete issue (owner/manager only) |

### Comments & Attachments

| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/issues/:id/comments` | Add comment |
| `DELETE` | `/comments/:id` | Delete comment |
| `POST` | `/issues/:id/attachments` | Upload file attachment |
| `DELETE` | `/attachments/:id` | Delete attachment |

---

## 🏗️ Folder Structure

```
bugtrackr-rails/
├── app/
│   ├── channels/          # ActionCable channels (BoardChannel)
│   ├── controllers/
│   │   └── api/v1/        # Versioned API controllers
│   ├── jobs/              # Sidekiq background jobs
│   ├── models/            # ActiveRecord models
│   ├── policies/          # Pundit authorization policies
│   └── serializers/       # JSON serializers
├── config/
│   ├── routes.rb
│   └── cable.yml          # ActionCable config
├── db/
│   ├── migrate/
│   └── seeds.rb
├── spec/                  # RSpec tests
│   ├── factories/
│   ├── models/
│   ├── requests/
│   └── policies/
└── .env.example
```

---

## 🛡️ Authorization

Roles are enforced per team using [Pundit](https://github.com/varvet/pundit) policies:

| Role | Permissions |
|---|---|
| `owner` | Full access — manage team, projects, issues, members |
| `manager` | Manage projects and issues; invite members |
| `developer` | Create and update issues; add comments and attachments |
| `viewer` | Read-only access to projects and boards |

---

## 🧪 Running Tests

```bash
bundle exec rspec
```

---

## 🧭 Future Improvements

- [ ] Search & advanced filtering
- [ ] Email notifications (Mailgun / SendGrid)
- [ ] Admin dashboard
- [ ] Docker + Docker Compose setup
- [ ] Deploy to Fly.io / Render
- [ ] Issue dependency graph
- [ ] Mention & @notify system

---

## 📄 License

[MIT](LICENSE) — free to use, modify, and distribute. No warranty provided.

---

## 🤝 Contributing

PRs are welcome. Please open an issue first to discuss major changes. Follow Rails conventions and write tests with RSpec.