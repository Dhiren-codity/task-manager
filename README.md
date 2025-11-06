# Task Manager API - Test Project

A simple Ruby application for testing **Automated Unit Testing** with RSpec.

## 📋 Overview

This is a lightweight task management system with:
- **User management** with karma system
- **Task CRUD** with status tracking
- **Statistics service** for productivity metrics
- **ActiveRecord models** with validations and associations

## 🏗️ Architecture

```
app/
├── models/
│   ├── task.rb
│   └── user.rb
└── services/
    └── task_statistics_service.rb

spec/
├── spec_helper.rb
├── factories/
│   ├── users.rb
│   └── tasks.rb
└── models/

config/
└── application.rb
```

## 🚀 Setup

```bash
# Install dependencies
bundle install

# Run tests
bundle exec rspec

# Run linter
bundle exec standardrb
```

## 📊 Key Features to Test

### Task Model
- ✅ Validations (title, status, priority)
- ✅ Scopes (pending, completed, overdue)
- ✅ Instance methods (complete!, overdue?, days_until_due)
- ✅ Business logic (progress_percentage)

### User Model
- ✅ Validations (email format, uniqueness)
- ✅ Associations (has_many tasks)
- ✅ Karma system (high_karma?, complete_task!)
- ✅ Statistics (completion_rate, has_overdue_tasks?)

### TaskStatisticsService
- ✅ Overall stats calculation
- ✅ Productivity scoring
- ✅ Priority distribution
- ✅ Average completion time

## 🎯 Perfect for Testing Automated Unit Testing

This codebase is designed to test the **Ruby Automated Unit Testing System** with:

1. **Clear, testable methods** - Each method has obvious test cases
2. **Multiple layers** - Models, services, validations
3. **Real business logic** - Karma, completion rates, productivity scores
4. **Edge cases** - Overdue tasks, banned users, nil handling
5. **ActiveRecord patterns** - Scopes, associations, validations

## 🧪 CI/CD

GitHub Actions workflow runs:
- RSpec tests with documentation format
- StandardRB linting
- Automatic on push/PR to main branch

## 📝 Example Usage

```ruby
# Create a user
user = User.create(name: "John Doe", email: "john@example.com")

# Create a task
task = user.tasks.create(
  title: "Write tests",
  status: "pending",
  priority: "high",
  due_date: 3.days.from_now
)

# Complete the task and earn karma
user.complete_task!(task)
puts user.karma  # => 10

# Check statistics
stats = TaskStatisticsService.new(user)
puts stats.productivity_score
```

## 🎓 Learning Goals

This project demonstrates:
- ✅ ActiveRecord models with validations
- ✅ Service objects for business logic
- ✅ FactoryBot for test data
- ✅ RSpec best practices
- ✅ Clean architecture
- ✅ Simple, testable code

Perfect for testing **automated test generation**!
