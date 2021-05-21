class Grant < ApplicationRecord
  validates :owner, presence: true
  validates :target, presence: true
  validates :owner, uniqueness: { scope: :target }
end
