class Project < ApplicationRecord
  has_many :tasks
  has_many :project_users
  has_many :users, through: :project_users

  scope :draft, -> { where(status: status[:draft]) }
  scope :in_progress, -> { where(status: status[:in_progress]) }
  scope :completed, -> { where(status: status[:completed]) }
  scope :archived, -> { where(status: status[:archived]) }

  enum status: { 
    draft: 0,
    to_do: 1,
    in_development: 2,
    completed: 3,
    archived: 4 
  }

  private 

end
