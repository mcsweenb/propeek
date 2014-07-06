class ProfileController < ApplicationController

#   before_filter :require_no_user, :only => [:login]

  before_filter :require_user, only: [:private]

  def create_review
    params.permit(:score, :review)

    @user = User.find_by_id(params[:for_user_id])
    if @user
      @review = @user.reviews_received.build(rating: params[:score], review: params[:review], review_by: current_user)
      if @review.save
        flash[:notice] = "Review saved"
      else
        flash[:notice] = @review.errors.full_messages
      end
    else
      flash[:notice] = "Bad request. No profile selected."
      redirect_to root_url and return
    end
    redirect_to profile_url(@user)
  end

  def show
    @body_class = 'profile'
    if params.include?(:user_id)
      @user = User.find_by_id(params[:user_id])
      unless @user
        redirect_to root_url, notice: "No such profile" and return
      end
    else
      if current_user
        @user = current_user
      else
        redirect_to root_url, notice: "No such profile" and return        
      end
    end
  end

  def private
    @user = current_user
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
          redirect_to profile_url(current_user) and return
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
