class RegisterController < ApplicationController

  before_filter :require_user, :except => [:step1]

  layout 'register'

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
    if request.post?
      current_user.bio = params[:user][:bio]
      current_user.update_list(Speciality, params[:user][:specialities])
      current_user.update_list(Membership, params[:user][:memberships])
      current_user.update_list(Language, params[:user][:languages])
      current_user.licensed_in = params[:user][:licensed_in]      
      current_user.linkedin_handle = params[:user][:linkedin_handle]      
      current_user.twitter_handle = params[:user][:twitter_handle]      

      if current_user.save
        @user.update_attribute(:registration_step_number, 2)
        render :step3
        return
      end
    end
  end

  def step3
  end

  def step4
  end

  private

  def set_body_class
    @body_class = 'register'
  end


end
