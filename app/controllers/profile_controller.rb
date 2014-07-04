class ProfileController < ApplicationController

  before_filter :require_no_user, :only => [:login]
  before_filter :require_user, :only => [:show]

  def show
    @body_class = 'profile'
    if params.include?(:id)
      @user = User.find_by_id(params[:id])
      if @user          
        render template: "profile/public" and return
      else
        redirect_to root_url, notice: "No such profile" and return
      end
    else
      if current_user
        @user = current_user
        render template: "profile/show" and return
      else
        redirect_to root_url, notice: "No such profile" and return        
      end
    end
  end

  def login
    @body_class = 'login'
    if request.post?
      @user_session = UserSession.new(:email => params[:user_session][:email], :password => params[:user_session][:password])
      if @user_session.save
        case @user_session.user.registration_step_number
        when 1
          redirect_to register2_url and return
        when 2
          redirect_to register3_url and return
        when 3
          redirect_to register4_url and return
        when 4
          redirect_to profile_url and return
        else
          redirect_to register_url and return
        end
      end
    else
      @user_session = UserSession.new
    end
  end

  def logout
    UserSession.find.destroy
    redirect_to root_url
  end

  def set_body_class
    @body_class = 'profile'
  end

end
