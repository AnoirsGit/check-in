class WorkingTime < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :user_id, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true
end
