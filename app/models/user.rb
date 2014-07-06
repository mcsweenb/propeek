class User < ActiveRecord::Base

  validates :email, presence: true

  validates :first_name, presence: true, length: {maximum: 128}
  validates :last_name, presence: true, length: {maximum: 128}

  validates :licensed_in, length: {maximum: 255, allow_nil: true}

  validates :linkedin_handle, length: {minimum: 5, maximum: 30, allow_nil: true}
  validates :twitter_handle, length: {maximum: 15, allow_nil: true}
  validates :bio, length: {maximum: 255, allow_nil: true}

  validates :company_name, length: {maximum: 128, allow_nil: true}
  validates :company_website, length: {maximum: 255, allow_nil: true}
  validates :job_title, length: {maximum: 128, allow_nil: true}

  validates :phone_1, length: {maximum: 3, allow_nil: true}
  validates :phone_2, length: {maximum: 3, allow_nil: true}
  validates :phone_3, length: {maximum: 4, allow_nil: true}


  validates :address_1, length: {maximum: 128, allow_nil: true}
  validates :address_2, length: {maximum: 128, allow_nil: true}
  validates :city, length: {maximum: 128, allow_nil: true}
  validates :state, length: {maximum: 15, allow_nil: true}
  validates :zip, length: {maximum: 32, allow_nil: true}

  monetize :min_hourly_cents, allow_nil: true,
  :numericality => {
    :greater_than_or_equal_to => 0,
  }
  monetize :max_hourly_cents, allow_nil: true,
  :numericality => {
    :greater_than_or_equal_to => 0,
  }
  monetize :min_daily_cents, allow_nil: true,
  :numericality => {
    :greater_than_or_equal_to => 0,
  }
  monetize :max_daily_cents, allow_nil: true,
  :numericality => {
    :greater_than_or_equal_to => 0,
  }


  acts_as_authentic do |c|
   c.validate_email_field = true
    c.login_field = :email
    
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
    c.validates_uniqueness_of_email_field_options[:case_sensitive] = false
  end 

  has_and_belongs_to_many :memberships
  has_and_belongs_to_many :specialities
  has_and_belongs_to_many :languages

  has_many :educations, -> {order :start_date}, inverse_of: :user
  accepts_nested_attributes_for :educations

  has_many :experiences, -> {order :start_date}, inverse_of: :user
  accepts_nested_attributes_for :experiences

  has_many :reviews_received, foreign_key: :review_for_id, class_name: 'Review'
  has_many :reviews_received_from, through: :reviews_received, source: :review_by

  has_many :reviews_given, foreign_key: :review_by_id, class_name: 'Review'
  has_many :reviews_given_to, through: :reviews_given, source: :review_for

  has_attached_file :avatar, 
  :styles => { :detail => "162x162", :thumb => "53x53" }, 
  :default_url => "/images/:style/missing.png"
  #:processors => [:cropper]  
  
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  #attr_accessor :crop_x, :crop_y, :crop_w, :crop_h  
  #after_update :reprocess_avatar, :if => :cropping? 

  def cropping?  
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?  
  end  
  
  def reprocess_avatar  
    avatar.reprocess!  
  end  


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

  def fullname
    "#{first_name} #{last_name}"
  end

  def company_address
    [address_1, address_2, city, state, zip].reject(&:blank?).join(", ")
  end

  def review_breakdown
    reviews = reviews_received.select('rating', 'count(*)').group(:rating).reorder(:rating).all
    total_count = reviews.map(&:count).sum
    breakdown = []
    (1..5).each do |i|
      r = reviews.find {|r| r.rating == i}
      if r.present?
        breakdown << [i, r.count, ((r.count.to_f/total_count) * 100).round]
      else
        breakdown << [i, 0, 0]
      end
    end
    breakdown.reverse
  end

end
