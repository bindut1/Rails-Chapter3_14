class User < ApplicationRecord
  VALID_EMAIL_REGEX_ADVANCED = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX_ADVANCED }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
