class User < ActiveRecord::Base

  has_secure_password

  validates :password, presence: true, confirmation: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true

end
