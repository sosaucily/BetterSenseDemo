class SysadminController < ApplicationController

before_filter :authenticate_admin!, :except=>[:session_test]

  def index
  end

  def session_test
  end
  
end
