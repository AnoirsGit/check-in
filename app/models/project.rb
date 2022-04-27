class Project < ApplicationRecord
  has_many :tasks
  has_many :project_users
  has_many :users, through: :project_users

  scope :draft, -> { where(status: status[:draft]) }
  scope :in_progress, -> { where(status: status[:in_progress]) }
  scope :completed, -> { where(status: status[:completed]) }
  scope :archived, -> { where(status: status[:archived]) }

  enum status: %i[draft to_do in_progress completed archived]

  def set_role(user, role)
    project_user = ProjectUser.find_by(user: user, project: self)
    project_user.role = role
    project_user.save
  end

  def owner?(user)
    ProjectUser.find_by(user: user, project: self, role: :owner).present?
  end

  def role?(user)
    ProjectUser.find_by(user: user, project: self).role
  end
end
