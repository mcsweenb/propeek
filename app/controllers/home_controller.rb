class HomeController < ApplicationController

  before_filter :require_no_user, :only => [:step1]
  layout false
  
  def index
  end
end
