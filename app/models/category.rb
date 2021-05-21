class Category < ApplicationRecord
  has_many :working_times

  validates :title, presence: true
end
