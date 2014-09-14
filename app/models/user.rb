class User < ActiveRecord::Base

  has_many :apps
  has_many :sensors
  has_many :actuators

  has_secure_password


  before_save { self.email = email.downcase }

  validates :email, email: true, if: :email
  validates :password, confirmation: true
  validates :email, :password_confirmation, presence: true
  validates :password, presence: true, on: :create
  validates :email, uniqueness: true

end
