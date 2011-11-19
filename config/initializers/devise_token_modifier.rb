require 'devise/strategies/base'
require 'devise/strategies/token_authenticatable'
module Devise
  module Strategies
    class TokenAuthenticatable < Authenticatable
      private
      def valid_request?
        params[:controller] == "api"
      end
    end
  end
end