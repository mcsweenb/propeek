RSpec.configure do |config|
  config.render_views

  config.include FactoryGirl::Syntax::Methods
  # config.before(:suite) do
  #   FactoryGirl.lint
  # end
end
