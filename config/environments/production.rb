P4::Application.configure do

  config.cache_classes = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.action_dispatch.x_sendfile_header = "X-Sendfile"
  config.serve_static_assets = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  
  require 'tlsmail'
  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.default_charset = "utf-8"
  ActionMailer::Base.raise_delivery_errors = true

  #ActionMailer::Base.smtp_settings = {
	#:address         => 'auth.smtp.vt.edu',
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
