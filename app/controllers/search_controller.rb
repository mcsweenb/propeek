class SearchController < ApplicationController

  def index
    @selected_profession = Profession.where(name: params[:profession]).first
    @selected_speciality = Speciality.where(name: params[:speciality]).first || @selected_profession.specialities.first

    @query = User.distinct("users.*").
      where(profession_name: params[:profession]).
      joins(:specialities).
      where(city: params[:city])

    unless params[:speciality].blank?
      @query = @query.where("specialities.name" => params[:speciality])
    end

    @results = @query.all

    @professions = Profession.all
    @specialities = @selected_profession.specialities
  end

  private

  def set_body_class
    @body_class = 'search'
  end

end
