class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project

  scope :owner, -> { where(role: :owner) }
  scope :member, -> { where(status: :in_progress) }

  enum role: %i[owner member]
end
