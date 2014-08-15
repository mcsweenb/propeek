RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  
    config.authenticate_with do |controller|
      if current_user.nil?
        session[:return_to] = request.url
        redirect_to main_app.login_url, :notice => "You must first log in or sign up before accessing this page."
      end
    end

    config.authorize_with do |controller|
      redirect_to main_app.root_url, :notice => "You are not authorized to access that page" unless current_user.try(:admin?)
    end
    
  end
end
