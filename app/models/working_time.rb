class WorkingTime < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user, presence: true
  validates :task, presence: true
  validates :started_at, presence: true

  # today_working_time
  scope :start, -> (user, task) { create(started_at: DateTime.now, user: user, task: task ) }
  scope :today, -> (user, task) { where(started_at: today_interval, user: user, task: task).where.not(ended_at: nil) }
  scope :today_total_hours, -> (user, task) { today(user, task).map { |w| w.hours }.sum  }

  def hours
    self.ended_at - self.started_at
  end

  private

  def self.today_interval
    Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
  end
  
end
