class User < ActiveRecord::Base

  validates :email, presence: true

  validates :first_name, presence: true, length: {maximum: 128}
  validates :last_name, presence: true, length: {maximum: 128}

  validates :linkedin_handle, length: {minimum: 5, maximum: 30, allow_nil: true}
  validates :twitter_handle, length: {maximum: 15, allow_nil: true}

  acts_as_authentic do |c|
   c.validate_email_field = true
    c.login_field = :email
    
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
    c.validates_uniqueness_of_email_field_options[:case_sensitive] = false
  end 

  has_and_belongs_to_many :memberships
  has_and_belongs_to_many :specialities
  has_and_belongs_to_many :languages

end
