require 'devise/strategies/base'
require 'devise/strategies/token_authenticatable'
module Devise
  module Strategies
    class TokenAuthenticatable < Authenticatable
      private
      def valid_request?
        valid_controllers = ['api','accounts']
        valid_controllers.include? params[:controller]
      end
    end
  end
end