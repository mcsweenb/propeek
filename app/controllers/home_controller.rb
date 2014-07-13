class HomeController < ApplicationController

  before_filter :require_no_user, :only => [:step1]
  layout false
  
  def index
    @professions = Profession.order(:name).all
    @specialities = Speciality.all
  end
  
  private

  def set_body_class
    @body_class = 'home'
  end


end
