class User < ActiveRecord::Base

  has_secure_password

  validates :password, presence: true, confirmation: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    user = self.find_by(email: email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end
