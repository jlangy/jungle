
class User < ActiveRecord::Base
  has_secure_password

  validates :password, length: {minimum: 3}
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: {:case_sensitive => false}, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_save { self.email = self.email.downcase }

  def self.authenticate_with_credentials(email, password)
    stripped_lower_case_email = email.strip.downcase unless email.nil?
    User.find_by(email: stripped_lower_case_email).try(:authenticate, password)
  end
end
