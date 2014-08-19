class HomeController < ApplicationController

  before_filter :require_no_user, :only => [:step1]
  layout false
  
  def index
    @professions = Profession.order(:name).all
    @selected_profession = @professions.first
    logger.debug @selected_profession.name
    logger.debug @selected_profession.id
    @specialities = @selected_profession.specialities
    logger.debug @specialities
    logger.debug @specialities.count
    @selected_speciality = @specialities.first
  end

  def specialities
    @profession = Profession.where(name: params[:profession]).first
    @specialities = @profession.specialities
  end
  
  private

  def set_body_class
    @body_class = 'home'
  end


end
