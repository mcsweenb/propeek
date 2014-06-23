class User < ActiveRecord::Base

  validates :email, presence: true

  validates :first_name, presence: true, length: {maximum: 128}
  validates :last_name, presence: true, length: {maximum: 128}

  validates :licensed_in, length: {maximum: 255, allow_nil: true}

  validates :linkedin_handle, length: {minimum: 5, maximum: 30, allow_nil: true}
  validates :twitter_handle, length: {maximum: 15, allow_nil: true}
  validates :bio, length: {maximum: 255, allow_nil: true}

  acts_as_authentic do |c|
   c.validate_email_field = true
    c.login_field = :email
    
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
    c.validates_uniqueness_of_email_field_options[:case_sensitive] = false
  end 

  has_and_belongs_to_many :memberships
  has_and_belongs_to_many :specialities
  has_and_belongs_to_many :languages

  def update_list(collection_class, params_list)
    unless params_list.blank?
      new_list = params_list.split(",").collect do |given|
        new_item = collection_class.find_or_initialize_by(name: given)
        if new_item.valid?
          new_item.save
          new_item
        else
          return false
        end
      end
      unless new_list.blank?
        self.send("#{collection_class.name.downcase.pluralize}=", new_list)
      end
    end
    self.send("#{collection_class.name.downcase.pluralize}")
  end

end
