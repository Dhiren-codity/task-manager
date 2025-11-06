require "active_record"

class User < ActiveRecord::Base
  has_many :tasks, dependent: :destroy

  validates :email, presence: true, uniqueness: true,
    format: {with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/}
  validates :name, presence: true, length: {minimum: 2, maximum: 50}

  KARMA_PER_COMPLETED_TASK = 10
  HIGH_KARMA_THRESHOLD = 100

  def complete_task!(task)
    return false unless task.user_id == id

    if task.complete!
      increment!(:karma, KARMA_PER_COMPLETED_TASK)
      true
    else
      false
    end
  end

  def high_karma?
    karma >= HIGH_KARMA_THRESHOLD
  end

  def pending_tasks_count
    tasks.pending.count
  end

  def completed_tasks_count
    tasks.completed.count
  end

  def completion_rate
    total = tasks.count
    return 0.0 if total.zero?

    (completed_tasks_count.to_f / total * 100).round(2)
  end

  def has_overdue_tasks?
    tasks.overdue.exists?
  end

  def active?
    !banned_at.present?
  end
end
