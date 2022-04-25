class Task < ApplicationRecord
  belongs_to :project
  has_many :user_tasks
  has_many :project_tasks
  has_many :working_times
  has_many :users, through: :user_tasks
  has_many :projects, through: :project_tasks
  
  scope :draft, -> { where(status: :draft) }
  scope :in_progress, -> { where(status: :in_progress) }
  scope :completed, -> { where(status: :completed) }
  scope :archived, -> { where(status: :archived) }

  enum status: %i[draft to_do in_progress completed archived]

  private 

end
