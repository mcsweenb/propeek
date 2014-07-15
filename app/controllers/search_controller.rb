class SearchController < ApplicationController

  def index
    logger.debug "search now... "
    # @users = User.joins("specialities").
    #   where(profession_name: params[:profession_name]).
    #   where("speciality.name" => params[:speciality]).
    #   where(city: params[:city]).all
    @results = User.all
  end

  private

  def set_body_class
    @body_class = 'search'
  end

end
