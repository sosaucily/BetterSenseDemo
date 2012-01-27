class CartsController < ApplicationController

  #Cart creation happens automatically through the sessioning system

  def index
    respond_to do |format|
      format.html { redirect_to (root_url) }
    end
  end

  # GET /cart/1
  # GET /cart/1.xml
  def show
    @cart = current_cart()
    respond_to do |format|
      format.html # show.html.erb
      format.js {render :partial => 'shared/refresh_cart', :layout => false } #, :notice => 'Ad was successfully updated.' }
    end
  end

  def destroy
  end

  def add_item
    #if (params[:cart_id] != session[:cart_id])
    @cart = current_cart()
    @cart.line_items.create(:quality => params[:quality], :video_id => params[:video_id])
    respond_to do |format|
      format.js {render :partial => 'shared/refresh_cart', :layout => false } #, :notice => 'Ad was successfully updated.' }
    end
  end
  
  def remove_item
    @cart = current_cart()
    @cart.line_items.find(params[:item_id]).destroy()
    respond_to do |format|
      format.js {render :partial => 'shared/refresh_cart', :layout => false } #, :notice => 'Ad was successfully updated.' }
    end
  end
  
  def clear_items
    @cart = current_cart()
    @cart.line_items.each do |item|
      item.destroy()
    end
    @cart = current_cart()
    respond_to do |format|
      format.js {render :partial => 'shared/refresh_cart', :layout => false } #, :notice => 'Ad was successfully updated.' }
    end
  end
end
