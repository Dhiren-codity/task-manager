class TaskStatisticsService
  def initialize(user)
    @user = user
  end

  def overall_stats
    {
      total_tasks: @user.tasks.count,
      pending: @user.tasks.pending.count,
      in_progress: @user.tasks.in_progress.count,
      completed: @user.tasks.completed.count,
      completion_rate: @user.completion_rate,
      overdue_count: @user.tasks.overdue.count
    }
  end

  def productivity_score
    return 0 if @user.tasks.count.zero?

    completed_weight = @user.completed_tasks_count * 10
    overdue_penalty = @user.tasks.overdue.count * -5
    karma_bonus = @user.karma / 10

    [completed_weight + overdue_penalty + karma_bonus, 0].max
  end

  def tasks_by_priority
    {
      low: @user.tasks.where(priority: "low").count,
      medium: @user.tasks.where(priority: "medium").count,
      high: @user.tasks.where(priority: "high").count,
      urgent: @user.tasks.where(priority: "urgent").count
    }
  end

  def average_completion_time
    completed_tasks = @user.tasks.completed.where.not(completed_at: nil)
    return nil if completed_tasks.empty?

    total_days = completed_tasks.sum do |task|
      next 0 unless task.created_at && task.completed_at
      (task.completed_at.to_date - task.created_at.to_date).to_i
    end

    (total_days.to_f / completed_tasks.count).round(2)
  end

  def needs_attention?
    @user.tasks.overdue.count > 3 || @user.completion_rate < 30
  end
end
