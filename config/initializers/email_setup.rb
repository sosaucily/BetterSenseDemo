ActionMailer::Base.smtp_settings = {
  :address              => "wp237.webpack.hosteurope.de",
  :port                 => 587,
  :domain               => "bettersense.com",
  :user_name            => "wp1187079-jesse_bettersense11",
  :password             => "playtime",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

#Use a YAML config file
#ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?