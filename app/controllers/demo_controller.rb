class DemoController < ApplicationController


  def index
  end

  def servePage
    @demo_name = params[:demo_name]
    render "/home/ubuntu/www/BetterSenseDemoDev/app/views/demo/" + @demo_name.to_s
  end

end
