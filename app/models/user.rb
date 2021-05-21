require 'securerandom'

class User < ApplicationRecord
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_one_attached :avatar
  has_person_name

  has_many :notifications, as: :recipient
  has_many :services
  has_many :working_times

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  def admin?
    role.eql?('admin')
  end

  def regular?
    role.eql?('regular')
  end

  def guest?
    role.eql?('guest')
  end

end
