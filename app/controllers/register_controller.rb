class RegisterController < ApplicationController

  before_filter :require_user, :except => [:step1]

  def step1
    if request.get?
      if current_user
        redirect_to self.send("register#{current_user.registration_step_number + 1}_path".to_sym) and return
      else
        @user = User.new
      end
      @professions = Profession.all
    elsif request.post?                                                                             
      @user = User.new(params[:user].permit(:email, :first_name, :last_name, :password, :password_confirmation, 
                                            :profession_name,
                                            :crop_w, :crop_h, :crop_x, :crop_y))
      @user.avatar = params[:user][:avatar]
      if @user.save
        @user.update_attribute(:registration_step_number, 1)
        render :step2
        return
      else
        @professions = Profession.all
        logger.debug @user.errors.full_messages
      end
    end
  end

  def step2
    @user = current_user
    base_errors = {}
    if request.post?
      if @user.update_attributes(params[:user].
                                 slice(:company_name, :company_website, :job_title, :bio,
                                       :company_website, :linkedin_handle,
                                       :phone_1, :phone_2, :phone_3,
                                       :address_1, :address_2, :city, :state, :zip).
                                 permit(:company_name, :company_website, :job_title, :bio,
                                        :company_website, :linkedin_handle,
                                        :phone_1, :phone_2, :phone_3,
                                        :address_1, :address_2, :city, :state, :zip)
                                 )
        unless @user.update_list(Speciality, params[:user][:specialities])
          base_errors[:specialities] = "too long"
        end
        unless @user.update_list(Membership, params[:user][:memberships])
          base_errors[:memberships] = "too long"
        end        
        if @user.valid? && base_errors.empty?
          @user.registration_step_number = 2
          @user.save
          render :step3 and return
        else
          base_errors.each do |k, e|
            @user.errors.add(k, e)
          end
        end
      else
        unless @user.errors[:base].empty?
          flash[:notice] = @user.errors[:base].first
        end
      end
    end
  end

  def step3
    @user = current_user
    if request.post?
      if @user.update_attributes(params[:user].
                                 permit(:min_hourly, :max_hourly, :fee_notes))
        @user.update_attribute(:registration_step_number, 3)
        redirect_to profile_private_url, notice: "Congrats! Your profile was successfully created." and return
      end
    end
  end

  private

  def set_body_class
    @body_class = 'register'
  end


end
