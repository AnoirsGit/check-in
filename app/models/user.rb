require 'securerandom'

class User < ApplicationRecord
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_one_attached :avatar
  has_person_name

  has_many :notifications, as: :recipient
  has_many :project_users
  has_many :project_tasks
  has_many :posts

  has_many :projects, through: :project_users
  has_many :tasks, through: :user_tasks

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
