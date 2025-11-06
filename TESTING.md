# Testing with Automated Unit Testing System

This document explains how to use this repository to test the **Ruby Automated Unit Testing** system.

## 🎯 Purpose

This is a **test repository** specifically designed to validate the automated test generation system. It contains:
- ✅ **3 testable files** with clear, simple logic
- ✅ **Multiple test scenarios** (validations, scopes, business logic)
- ✅ **Real ActiveRecord patterns** (associations, callbacks)
- ✅ **Service objects** with complex logic
- ✅ **CI configuration** matching lobsters setup

## 📁 Files to Generate Tests For

### 1. `lib/task.rb` - Task Model
**Methods to test:**
- `complete!` - Marks task as completed
- `cancel!` - Marks task as cancelled
- `overdue?` - Checks if task is overdue
- `urgent?` - Checks if task is urgent priority
- `days_until_due` - Calculates days remaining
- `progress_percentage` - Returns completion percentage

**Test scenarios:**
- Validations (title presence, status values, priority values)
- Scopes (pending, completed, in_progress, high_priority, overdue)
- Status transitions
- Date calculations
- Edge cases (nil due_date, completed tasks)

### 2. `lib/user.rb` - User Model
**Methods to test:**
- `complete_task!` - Completes task and awards karma
- `high_karma?` - Checks if user has high karma
- `pending_tasks_count` - Count pending tasks
- `completed_tasks_count` - Count completed tasks
- `completion_rate` - Calculate completion percentage
- `has_overdue_tasks?` - Check for overdue tasks
- `active?` - Check if user is active

**Test scenarios:**
- Email validation and uniqueness
- Name validation
- Karma system (earning, thresholds)
- Task associations
- Completion rate calculations
- Active/banned status

### 3. `lib/task_statistics_service.rb` - Statistics Service
**Methods to test:**
- `overall_stats` - Returns comprehensive statistics
- `productivity_score` - Calculates productivity score
- `tasks_by_priority` - Groups tasks by priority
- `average_completion_time` - Average days to complete
- `needs_attention?` - Alert for low productivity

**Test scenarios:**
- Statistics calculation with various data
- Score calculations (weights, penalties, bonuses)
- Edge cases (zero tasks, all overdue)
- Nil handling

## 🚀 How to Test the Automated System

### Step 1: Clone/Setup
```bash
cd /home/dhiren-mhatre/task-manager-api
bundle install
```

### Step 2: Generate Tests
Use your automated testing system to generate tests for:
```
lib/task.rb       → spec/models/task_spec.rb
lib/user.rb       → spec/models/user_spec.rb
lib/task_statistics_service.rb → spec/services/task_statistics_service_spec.rb
```

### Step 3: Run Generated Tests
```bash
bundle exec rspec
```

### Step 4: Verify Quality
Check that generated tests:
- ✅ Use FactoryBot correctly
- ✅ Test all public methods
- ✅ Cover edge cases
- ✅ Have no empty describe blocks
- ✅ Pass on first run (or require minimal fixes)

## 🎓 Expected Test Coverage

### Task Model (~15-20 tests)
- Validation tests (5-7 tests)
- Scope tests (5-6 tests)
- Method tests (5-7 tests)

### User Model (~12-15 tests)
- Validation tests (3-4 tests)
- Association tests (2 tests)
- Karma system tests (3-4 tests)
- Statistics tests (4-5 tests)

### TaskStatisticsService (~10-12 tests)
- Overall stats (2-3 tests)
- Productivity score (3-4 tests)
- Priority distribution (2 tests)
- Average completion time (2-3 tests)

## ✅ Success Criteria

The automated testing system should:
1. **Generate tests without manual intervention**
2. **Tests pass on first CI run** (or with < 3 fix attempts)
3. **No empty describe/context blocks** in output
4. **Proper FactoryBot usage** (no mocks for models)
5. **All public methods tested** (90%+ coverage)
6. **Clear test descriptions** following RSpec conventions

## 🐛 Common Issues to Watch For

### Instance Variables
- Models don't use controllers, so no `@user` issues
- Services receive objects as parameters
- No need for `controller.instance_variable_set`

### Validations
- Test both valid and invalid cases
- Use `be_valid` and `be_invalid` matchers
- Check error messages with `.errors[:field]`

### Scopes
- Use `let!` to create records before testing scopes
- Test scope chaining
- Verify correct records are returned

### Service Objects
- Initialize with required parameters (user, task)
- Test calculations with various scenarios
- Handle nil/edge cases

## 📊 Metrics to Track

After automated test generation:
- **Generation time** - How long to generate all tests
- **Initial pass rate** - % of tests passing before fixes
- **Fix attempts needed** - Number of CI runs to get all passing
- **Final coverage** - Line/method coverage percentage
- **Empty blocks** - Should be 0
- **Lint violations** - Should be < 5

## 💡 Tips for Presentation

Use this repo to demonstrate:
1. **"Watch me generate tests for Task model"** - Live demo
2. **"All tests pass immediately"** - Show CI green
3. **"Clean, readable tests"** - Show generated code quality
4. **"Comprehensive coverage"** - Show coverage report
5. **"No manual intervention"** - Emphasize automation

This is the **perfect demo repository** for your presentation!
