class ProfileController < ApplicationController

  before_filter :require_no_user, :only => [:login]
  before_filter :require_user, :only => [:show]

  def show
  end

  def login
    @body_class = 'login'
    if request.post?
      @user_session = UserSession.new(:email => params[:user][:email], :password => params[:user][:password])
      if @user_session.save
        redirect_to profile_url
        return
      end
    else
      @user_session = UserSession.new
    end
    render :layout => 'register'
  end

  def set_body_class
    @body_class = 'profile'
  end

end
