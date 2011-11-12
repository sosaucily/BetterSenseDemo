# This is part of the BetterSense Web system
#
# Author::    Jesse Smith  (mailto:js@bettersense.com)
# Copyright:: Copyright (c) 2011 BetterSense

class AccountsController < ApplicationController

  before_filter :authenticate_user!, :except => ['new','create','index']
  before_filter :check_session, :except => ['new','create','index']
  # GET /accounts
  # GET /accounts.xml
  def index
    if (admin_signed_in?) #For now, just admin protect some functions
      @accounts = Account.all
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @accounts }
      end
    else
      flash[:notice] = 'This function if for administrators only.'
      redirect_to "/admins/sign_in"
    end
  end

  # GET /accounts/1
  # GET /accounts/1.xml
  # GET /account
  def show
    id = session[:account_id]
    @account = Account.find(id)
    @campaigns = Campaign.find(:all, :limit => 3, :order => "updated_at desc", :conditions => "account_id = #{id}") #Show three most recently modified Campaigns in the quick view
    @ads = Ad.find(:all, :limit => 3, :order => "updated_at desc", :conditions => "account_id = #{id}") #Show three most recently modified Ads in the quick view
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.xml
  def new
    if (admin_signed_in?) #For now, just admin protect some functions
      @account = Account.new
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @account }
      end
    else
      flash[:notice] = 'This function if for administrators only.'
      redirect_to "/admins/sign_in"
    end
  end

  # GET /accounts/1/edit
  # GET /account/edit
  def edit
    id = session[:account_id]
    @account = Account.find(id)
  end

  # POST /accounts
  # POST /accounts.xml
  def create
    if (admin_signed_in?) #For now, just admin protect some functions
      @account = Account.new(params[:id])
      respond_to do |format|
        if @account.save
          format.html { redirect_to(@account, :notice => 'Account was successfully created.') }
          format.xml  { render :xml => @account, :status => :created, :location => @account }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:notice] = 'This function if for administrators only.'
      redirect_to "/admins/sign_in"
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.xml
  def update
      id = session[:account_id]
      @account = Account.find(id)

      respond_to do |format|
        if @account.update_attributes(params[:account])
          format.html { redirect_to('/account', :notice => 'Account was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
        end
      end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.xml
  def destroy
    if (admin_signed_in?) #For now, just admin protect some functions
      @account = Account.find(params[:id])
      @account.destroy

      respond_to do |format|
        format.html { redirect_to(accounts_url) }
        format.xml  { head :ok }
      end
    else
      flash[:notice] = 'This function if for administrators only.'
      redirect_to "/admins/sign_in"
    end
  end
end
