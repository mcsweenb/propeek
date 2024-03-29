class User < ActiveRecord::Base

  validates :email, presence: true
  validates :profession_name, presence: true, length: {maximum: 64}

  validates :first_name, presence: true, length: {maximum: 128}
  validates :last_name, presence: true, length: {maximum: 128}

  validates :licensed_in, length: {maximum: 255, allow_nil: true}

  validates :linkedin_handle, length: {minimum: 5, maximum: 30, allow_nil: true}
  validates :twitter_handle, length: {maximum: 15, allow_nil: true}
  validates :bio, length: {maximum: 255, allow_nil: true}

  validates :company_name, length: {maximum: 128, allow_nil: true}
  validates :company_website, length: {maximum: 255, allow_nil: true, message: "is too long"}
  validates :job_title, length: {maximum: 128, allow_nil: true}

  validates :phone_1, length: {maximum: 3, allow_nil: true}
  validates :phone_2, length: {maximum: 3, allow_nil: true}
  validates :phone_3, length: {maximum: 4, allow_nil: true}

  validates :address_1, length: {maximum: 128}
  validates :address_2, length: {maximum: 128}
  validates :city, length: {maximum: 128}
  validates :state, length: {maximum: 64}
  validates :zip, length: {maximum: 32}

  validates :fee_notes, length: {maximum: 255, allow_nil: true}

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
  def speciality
    specialities.first.try(:name)
  end
  has_and_belongs_to_many :languages

  belongs_to :profession, primary_key: :name, foreign_key: :profession_name, inverse_of: :users

  has_many :educations, -> {order :start_date}, inverse_of: :user
  accepts_nested_attributes_for :educations

  has_many :experiences, -> {order :start_date}, inverse_of: :user
  accepts_nested_attributes_for :experiences

  has_many :reviews_received, foreign_key: :review_for_id, class_name: 'Review', inverse_of: :review_for
  has_many :reviews_received_from, through: :reviews_received, source: :review_by

  has_many :reviews_given, foreign_key: :review_by_id, class_name: 'Review', inverse_of: :review_by
  has_many :reviews_given_to, through: :reviews_given, source: :review_for

  has_attached_file :avatar, 
  styles: { profile_detail: "324x324>", profile_thumb: "120x120>", comment_thumb: "107x107>" }, 
  default_url: "/images/default_avatar/:style/missing.png",
  processors:  [:cropper]
  
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h  

  geocoded_by :company_address do |obj, result|
    if !result.empty? && 
        result.first.longitude &&
        result.first.latitude
      obj.lonlat = "POINT(#{result.first.longitude} #{result.first.latitude})"
    else
      obj.errors[:base] << "Invalid address. Please provide a valid address"
    end
  end

  before_validation do    
    if !(changed_attributes.keys & %w(address_1 address_2 city state zip)).empty?
      begin
        geocode
      rescue
        errors[:base] << "Invalid address. Please provide a valid address"
      end
    end
  end

  before_validation do 
    handle_url(:company_website, company_website)
  end

  def handle_url(attr, value)
    return if value.blank?
    u = URI.parse(value)
    if(!u.scheme)
      value = send("#{attr}=".to_sym, "http://#{value}")
      handle_url(attr, value)
    elsif(%w{http https}.include?(u.scheme))
      # you're okay
    # else
    #   errors.add(attr, "Bad URL")
    end
  end

  def update_list(collection_class, params_list, parent_record = nil, parent_key = nil)
    unless params_list.blank?
      new_list = params_list.split(",").collect do |given|
        if parent_record
          if parent_key
            found_item = collection_class.where(name: given).where("#{parent_key}" => parent_record.id).first
            if found_item
              new_item = found_item
            else
              new_item = collection_class.new(:name => given, "#{parent_key}" => parent_record.id)
            end
          else
            raise ArgumentError "parent_record and parent_key both should be defined"
          end
        else
          new_item = collection_class.find_or_initialize_by(name: given)
        end
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

  def num_reviews
    reviews_received.count
  end

  def average_rating
    reviews = reviews_received.select('rating', 'count(*)').group(:rating)
    total_score, count = 0, 0
    reviews.each do |r| 
      total_score += r.rating.to_i * r.count;  
      count += r.count
    end
    if count > 0
      (total_score / count.to_f).round
    else
      0
    end
  end

  def review_breakdown
    reviews = reviews_received.select('rating', 'count(*)').group(:rating).reorder(:rating).all
    total_count = reviews.map(&:count).sum
    breakdown = []
    (1..5).each do |i|
      r = reviews.find {|rr| rr.rating == i}
      if r.present?
        breakdown << [i, r.count, ((r.count.to_f/total_count) * 100).round]
      else
        breakdown << [i, 0, 0]
      end
    end
    breakdown.reverse
  end

end
