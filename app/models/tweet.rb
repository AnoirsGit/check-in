class Tweet < ApplicationRecord
  validates :body, presence: true
  validates :likes, presence: true
  validates :retweets, presence: true

  after_create_commit { broadcast_prepend_to 'tweets' }
end
