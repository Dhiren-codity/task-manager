require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }
  let(:other_user) { create(:user) }
  let(:other_task) { create(:task, user: other_user) }

  describe '#complete_task!' do
    context 'when the task belongs to the user' do
      it 'completes the task and increments karma' do
        allow(task).to receive(:complete!).and_return(true)
        expect { user.complete_task!(task) }.to change { user.karma }.by(User::KARMA_PER_COMPLETED_TASK)
      end

      it 'returns true if the task is completed' do
        allow(task).to receive(:complete!).and_return(true)
        expect(user.complete_task!(task)).to be true
      end

      it 'returns false if the task cannot be completed' do
        allow(task).to receive(:complete!).and_return(false)
        expect(user.complete_task!(task)).to be false
      end
    end

    context 'when the task does not belong to the user' do
      it 'does not complete the task and returns false' do
        expect(user.complete_task!(other_task)).to be false
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
      create_list(:task, 3, user: user, status: 'pending')
      expect(user.pending_tasks_count).to eq(3)
    end
  end

  describe '#completed_tasks_count' do
    it 'returns the count of completed tasks' do
      create_list(:task, 2, user: user, status: 'completed')
      expect(user.completed_tasks_count).to eq(2)
    end
  end

  describe '#completion_rate' do
    it 'returns 0.0 if there are no tasks' do
      expect(user.completion_rate).to eq(0.0)
    end

    it 'calculates the completion rate correctly' do
      create_list(:task, 2, user: user, status: 'completed')
      create_list(:task, 2, user: user, status: 'pending')
      expect(user.completion_rate).to eq(50.0)
    end
  end

  describe '#has_overdue_tasks?' do
    it 'returns true if there are overdue tasks' do
      create(:task, user: user, status: 'overdue')
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
      user.update(banned_at: Time.current)
      expect(user.active?).to be false
    end
  end
end