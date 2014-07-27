class SearchController < ApplicationController

  def index
  end

  def filters
    @professions = Profession.order("name asc")
    @specialities = Speciality.order("name asc")
    render json: {professions: @professions, specialities: @specialities}
  end

  def results
    if params.include?(:profession) ||
        params.include?(:speciality) ||
        params.include?(:city)
      @results = User.joins(:specialities).where("specialities.id" => params[:speciality]['id']).
        where("profession_name" => params[:profession]['name']).
        where("city" => params[:city]).all                                      
    else
      @results = User.all
    end
  end

  private

  def set_body_class
    @body_class = 'search'
  end

end
