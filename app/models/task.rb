require "active_record"

class Task < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: {minimum: 3, maximum: 100}
  validates :status, inclusion: {in: %w[pending in_progress completed cancelled]}
  validates :priority, inclusion: {in: %w[low medium high urgent]}, allow_nil: true

  scope :pending, -> { where(status: "pending") }
  scope :completed, -> { where(status: "completed") }
  scope :in_progress, -> { where(status: "in_progress") }
  scope :high_priority, -> { where(priority: %w[high urgent]) }
  scope :overdue, -> { where("due_date < ? AND status != ?", Date.today, "completed") }

  def complete!
    update(status: "completed", completed_at: Time.current)
  end

  def cancel!
    update(status: "cancelled")
  end

  def overdue?
    due_date.present? && due_date < Date.today && status != "completed"
  end

  def urgent?
    priority == "urgent"
  end

  def days_until_due
    return nil unless due_date
    (due_date - Date.today).to_i
  end

  def progress_percentage
    return 0 if status == "pending"
    return 100 if status == "completed"
    return 0 if status == "cancelled"
    50 # in_progress
  end
end
