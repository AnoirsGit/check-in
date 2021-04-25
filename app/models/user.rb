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

  def can_start_timer?
    self.working_times.last&.ended_at != nil || self.working_times.empty?
  end

  def get_total_time
    @total = 0
    self.working_times.each { |wt| @total += (wt.ended_at - wt.started_at) / 1.hours }
    @total.round(3)
  end
end
