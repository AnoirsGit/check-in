class Grant < ApplicationRecord
  validates :owner, uniqueness: { scope: :target }
end
