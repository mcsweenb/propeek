class RegisterController < ApplicationController

  before_filter :require_user, :except => [:step1]

  def step1
    if request.get?
      if current_user
        redirect_to self.send("register#{current_user.registration_step_number + 1}_path".to_sym) and return
      else
        @user = User.new
      end
    elsif request.post?
      @user = User.create(params[:user].
                          slice(:email, :first_name, :last_name, :password, :password_confirmation).
                          permit(:email, :first_name, :last_name, :password, :password_confirmation)
                          )
      if @user.valid?
        @user.update_attribute(:registration_step_number, 1)
        render :step2
        return
      end
    end
  end

  def step2
    @user = current_user
    base_errors = {}
    if request.post?      
      @user.bio = params[:user][:bio]
      unless @user.update_list(Speciality, params[:user][:specialities])
        base_errors[:specialities] = "too long"
      end
      unless @user.update_list(Membership, params[:user][:memberships])
        base_errors[:memberships] = "too long"
      end
      unless @user.update_list(Language, params[:user][:languages])
        base_errors[:languages] = "too long"
      end
      @user.licensed_in = params[:user][:licensed_in]      
      @user.linkedin_handle = params[:user][:linkedin_handle]      
      @user.twitter_handle = params[:user][:twitter_handle]      

      if @user.valid? && base_errors.empty?
        @user.registration_step_number = 2
        @user.save
        render :step3 and return
      else
        base_errors.each do |k, e|
          @user.errors.add(k, e)
        end
      end
    end
  end

  def step3
    @user = current_user
    if request.post?
      if @user.update_attributes(params[:user].
                                 slice(:company_name, :company_website, :job_title, 
                                       :phone_1, :phone_2, :phone_3, 
                                       :address_1, :address_2, :city, :state, :zip,
                                       :min_hourly, :max_hourly, :min_daily, :max_daily).
                                 permit(:company_name, :company_website, :job_title,
                                        :phone_1, :phone_2, :phone_3, 
                                        :address_1, :address_2, :city, :state, :zip,
                                        :min_hourly, :max_hourly, :min_daily, :max_daily)
                                 )
        @user.update_attribute(:registration_step_number, 3)
        render :step4
        return
      end
    end
  end

  def step4
    @user = current_user
    if request.post?

      permitted = params[:user].permit(educations: [:id, :qualification, :institution, :description, :start_date, :end_date],
                                       experiences: [:id, :company_name, :company_website, :title, :description, :start_date, :end_date])
      if @user.update_attributes(educations_attributes: permitted[:educations],
                                 experiences_attributes: permitted[:experiences])
        @user.update_attribute(:registration_step_number, 4)
        redirect_to profile_url
        return
       else
        
      end
    else
      @user.educations.build
      @user.experiences.build
    end
  end

  private

  def set_body_class
    @body_class = 'register'
  end


end
