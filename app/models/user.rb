require 'securerandom'

class User < ApplicationRecord
  after_create :set_code
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_one_attached :avatar
  has_person_name

  has_many :notifications, as: :recipient
  has_many :services
  has_many :working_times

  def set_code
    get_code

    get_code while User.find_by(code: @code)
    self.update(code: @code)
  end

  def get_code
    @code = SecureRandom.urlsafe_base64(5)
  end
end
