# Load the rails application
require File.expand_path('../application', __FILE__)
# Initialize the rails application
BetterSenseDemo::Application.initialize!

Mime::Type.register "text/markdown", :markdown

APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/bettersense_config.yml")[RAILS_ENV]
