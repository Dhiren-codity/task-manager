require 'rails_helper'

RSpec.describe User do
  let(:user) { User.create(email: 'test@example.com', name: 'Test User', karma: 0) }
  let(:task) { Task.create(user: user, completed: false) }

  describe '#complete_task!' do
    context 'when the task belongs to the user' do
      it 'completes the task and increments karma' do
        expect(task.completed).to be false
        expect(user.karma).to eq(0)

        result = user.complete_task!(task)

        expect(result).to be true
        expect(task.reload.completed).to be true
        expect(user.reload.karma).to eq(User::KARMA_PER_COMPLETED_TASK)
      end
    end

    context 'when the task does not belong to the user' do
      let(:other_user) { User.create(email: 'other@example.com', name: 'Other User') }
      let(:other_task) { Task.create(user: other_user, completed: false) }

      it 'does not complete the task or increment karma' do
        result = user.complete_task!(other_task)

        expect(result).to be false
        expect(other_task.reload.completed).to be false
        expect(user.reload.karma).to eq(0)
      end
    end
  end

  describe '#high_karma?' do
    it 'returns true if karma is above the high karma threshold' do
      user.update(karma: User::HIGH_KARMA_THRESHOLD + 1)
      expect(user.high_karma?).to be true
    end

    it 'returns false if karma is below the high karma threshold' do
      user.update(karma: User::HIGH_KARMA_THRESHOLD - 1)
      expect(user.high_karma?).to be false
    end
  end

  describe '#pending_tasks_count' do
    it 'returns the count of pending tasks' do
      Task.create(user: user, completed: false)
      Task.create(user: user, completed: false)
      expect(user.pending_tasks_count).to eq(2)
    end
  end

  describe '#completed_tasks_count' do
    it 'returns the count of completed tasks' do
      Task.create(user: user, completed: true)
      Task.create(user: user, completed: true)
      expect(user.completed_tasks_count).to eq(2)
    end
  end

  describe '#completion_rate' do
    it 'returns 0.0 if there are no tasks' do
      expect(user.completion_rate).to eq(0.0)
    end

    it 'calculates the completion rate correctly' do
      Task.create(user: user, completed: true)
      Task.create(user: user, completed: false)
      expect(user.completion_rate).to eq(50.0)
    end
  end

  describe '#has_overdue_tasks?' do
    it 'returns true if there are overdue tasks' do
      allow(user.tasks).to receive(:overdue).and_return(double(exists?: true))
      expect(user.has_overdue_tasks?).to be true
    end

    it 'returns false if there are no overdue tasks' do
      allow(user.tasks).to receive(:overdue).and_return(double(exists?: false))
      expect(user.has_overdue_tasks?).to be false
    end
  end

  describe '#active?' do
    it 'returns true if the user is not banned' do
      expect(user.active?).to be true
    end

    it 'returns false if the user is banned' do
      user.update(banned_at: Time.current)
      expect(user.active?).to be false
    end
  end
end