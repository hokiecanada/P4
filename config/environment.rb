# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
P4::Application.initialize!

Rails::Initializer.run do |config|
	config.time_zone = "Eastern Time (US & Canada)
end