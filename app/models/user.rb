# user model for the form
class User < ApplicationRecord
  has_secure_password

  validates :username, :password, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :email, format: {
                      with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]{2,}\z/i,
                      message: "'%{value}' is not a valid email"
                    }
  validates :password, confirmation: true, unless: -> { password.blank? }
  validates :password, length: { minimum: 10 }
end
