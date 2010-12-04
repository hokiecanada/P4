P4::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
	
  require 'tlsmail'
  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.default_charset = "utf-8"
  ActionMailer::Base.raise_delivery_errors = true

  #ActionMailer::Base.smtp_settings = {
#	:address         => 'auth.smtp.vt.edu',
	#:port            => 465,
	#:tls             => true,
	#:authentication  => :login,
	#:user_name       => 'cstinson',
	#:password        => 'number1'
  #}
  
  ActionMailer::Base.smtp_settings = {
  :address         => 'smtp.gmail.com',
  :port            => 587,
  :tls             => true,
  :authentication  => :login,
  :user_name       => 'hokiecanada',
  :password        => 'number17'
}
end

