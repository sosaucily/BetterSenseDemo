#1/12/12
#I'm turning this off, because although it seems to set the HTTP_COOKIE element correctly, I still can't access the 'session' variable.  Don't know why...

require 'rack/utils'

#BetterSenseDemo::Application.middleware.use Oink::Middleware
BetterSenseDemo::Application.middleware.use( Oink::Middleware, :logger => Rails.logger )


class FlashSessionCookieMiddleware
  def initialize(app, session_key = '_session_id')
    @app = app
    @session_key = session_key
  end

  def call(env)
    if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
      #puts "This is a flash event"
      req = Rack::Request.new(env)
      #puts "Got request params of " + req.params.to_s
      #puts "starting cookie session is : " + env['HTTP_COOKIE'].to_s
      env['HTTP_COOKIE'] = decode req.params["session_encoded"] unless req.params["session_encoded"].nil?
      #puts "New cookie is " + env['HTTP_COOKIE'].to_s
      #puts "final env is " + env.to_s
      #env['HTTP_COOKIE'] = req.params["session_encoded"] unless req.params["session_encoded"].nil?
    end
    @app.call(env)
  end

  private

  def decode(s)
    s.split("x").map{|x| x.to_i.chr}.join
  end
  
end

#1/12/12
#I'm turning this off, because although it seems to set the HTTP_COOKIE element correctly, I still can't access the 'session' variable.  Don't know why...
Rails.configuration.middleware.insert_before(ActionDispatch::Session::CookieStore, FlashSessionCookieMiddleware, Rails.configuration.secret_token)