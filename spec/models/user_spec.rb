require 'spec_helper'

RSpec.describe User do
  let(:user) { User.create(email: 'test@example.com', name: 'Test User', karma: 0) }
  let(:task) { Task.create(user: user, completed: false) }

  describe '#complete_task!' do
    context 'when task belongs to the user' do
      it 'completes the task and increments karma' do
        expect(task).to receive(:complete!).and_return(true)
        expect { user.complete_task!(task) }.to change { user.karma }.by(User::KARMA_PER_COMPLETED_TASK)
      end

      it 'returns true if task is completed successfully' do
        allow(task).to receive(:complete!).and_return(true)
        expect(user.complete_task!(task)).to be true
      end

      it 'returns false if task completion fails' do
        allow(task).to receive(:complete!).and_return(false)
        expect(user.complete_task!(task)).to be false
      end
    end

    context 'when task does not belong to the user' do
      let(:other_user) { User.create(email: 'other@example.com', name: 'Other User') }
      let(:other_task) { Task.create(user: other_user, completed: false) }

      it 'returns false' do
        expect(user.complete_task!(other_task)).to be false
      end
    end
  end

  describe '#high_karma?' do
    it 'returns true if karma is above the high threshold' do
      user.update(karma: User::HIGH_KARMA_THRESHOLD + 1)
      expect(user.high_karma?).to be true
    end

    it 'returns false if karma is below the high threshold' do
      user.update(karma: User::HIGH_KARMA_THRESHOLD - 1)
      expect(user.high_karma?).to be false
    end
  end

  describe '#pending_tasks_count' do
    it 'returns the count of pending tasks' do
      Task.create(user: user, completed: false)
      expect(user.pending_tasks_count).to eq(2)
    end
  end

  describe '#completed_tasks_count' do
    it 'returns the count of completed tasks' do
      task.update(completed: true)
      expect(user.completed_tasks_count).to eq(1)
    end
  end

  describe '#completion_rate' do
    it 'returns 0.0 if there are no tasks' do
      user.tasks.destroy_all
      expect(user.completion_rate).to eq(0.0)
    end

    it 'calculates the completion rate correctly' do
      Task.create(user: user, completed: true)
      expect(user.completion_rate).to eq(50.0)
    end
  end

  describe '#has_overdue_tasks?' do
    it 'returns true if there are overdue tasks' do
      Task.create(user: user, due_date: Date.yesterday)
      expect(user.has_overdue_tasks?).to be true
    end

    it 'returns false if there are no overdue tasks' do
      expect(user.has_overdue_tasks?).to be false
    end
  end

  describe '#active?' do
    it 'returns true if the user is not banned' do
      expect(user.active?).to be true
    end

    it 'returns false if the user is banned' do
      user.update(banned_at: Time.now)
      expect(user.active?).to be false
    end
  end
end