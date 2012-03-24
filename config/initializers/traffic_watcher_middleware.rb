#1/12/12
#I'm turning this off, because although it seems to set the HTTP_COOKIE element correctly, I still can't access the 'session' variable.  Don't know why...

require 'rack/utils'

#BetterSenseDemo::Application.middleware.use Oink::Middleware
#BetterSenseDemo::Application.middleware.use( Oink::Middleware, :logger => Rails.logger )


class TrafficWatcherMiddleware
  def initialize(app, session_key = '_session_id')
    @app = app
    @session_key = session_key
  end

  def call(env)
    if !@session_key.nil?
      #puts "Got session id of " + @session_key.to_s + " at IP of " + env['action_dispatch.remote_ip'].to_s
      TrafficWatcher.create :source_ip => env['action_dispatch.remote_ip'].to_s,  :session_id => @session_key.to_s, :path => env['PATH_INFO'].to_s
      ActiveRecord::Base.clear_active_connections!
    end

    @app.call(env)
  end

  private

end

Rails.configuration.middleware.insert_before(ActionDispatch::Session::CookieStore, TrafficWatcherMiddleware, Rails.configuration.secret_token)