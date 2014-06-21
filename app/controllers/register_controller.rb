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
    if request.post?
      current_user.bio = params[:user][:bio]
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
