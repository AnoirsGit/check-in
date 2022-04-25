class WorkingTime < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user, presence: true
  validates :task, presence: true
  validates :started_at, presence: true

  # today_working_time
  scope :ticking, -> (user, task) { where(user: user, task: task, ended_at: nil)}
  scope :completed, -> (user, task) { where(user: user, task: task).where.not(ended_at: nil) }
  scope :started_today, -> (user, task) { where(started_at: Date.today, user: user, task: task).where.not(ended_at: nil) }
  scope :start, -> (user, task) { create(started_at: DateTime.now, user: user, task: task ) }
  scope :end, -> (user, task) { ticking(user,task).first.update(ended_at: DateTime.now) }

  def self.today_total_with_ticking(user, task)
    ticking = self.ticking(user, task).map { |w| w.interval_from_start }.sum
    return today_total(user, task) + ticking if ticking.present? 
    today_total(user, task)
  end

  def self.today_total(user, task)
    started_today(user, task).map { |w| w.interval_from_start }.sum
  end

  def self.total(user, task)
    completed(user, task).map { |w| w.interval_from_start }.sum
  end

  def interval_from_start
    ended_at = self.ended_at || DateTime.now
    self.ended_at - started_at
  end

  private
  
end
