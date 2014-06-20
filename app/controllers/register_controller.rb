class RegisterController < ApplicationController

  layout 'register'

  def step1
    if request.get?
      @user = User.new
    elsif request.post?
      @user = User.new(params[:user].
                       slice(:email, :first_name, :last_name, :password, :password_confirmation).
                       permit(:email, :first_name, :last_name, :password, :password_confirmation)
                       )
      if @user.save
        render :step2
        return
      end
    end
  end

  def step2
  end

  def step3
  end

  def step4
  end

end
