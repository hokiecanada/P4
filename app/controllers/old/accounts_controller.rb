class AccountsController < ApplicationController

  before_filter :get_user
  before_filter :authenticate_user!
  
  def get_user
	#@user = User.find(params[:user_id])
	@user = current_user
  end
  
  def index
	@entries = @user.entries
	#@saved = Entry.find
	respond_to do |format|
		format.html # user.html.erb
	end
  end

  
  def show
    @entry = @user.entries.find(params[:id])
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
	  format.rss { render :rss => @entry }
    end
  end


  def new
    @entry = @user.entries.build
	@systems = Array.new[System.find(:all).size]
	@components = Array.new[Component.find(:all).size]
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end


  def edit
    @entry = @user.entries.find(params[:id])
	@systems = Array.new[System.find(:all).size]
	@components = Array.new[Component.find(:all).size]
  end


  def create
    @entry = @user.entries.create(params[:entry])
	@entry.viewed = 0
	@entry.status = "Pending"
	
	@systems = params[:systems]
	@systems.each do |s|
		@entry.system_list.add(s)
	end	
	
	@components = params[:components]
	@components.each do |c|
		@entry.comp_list.add(c)
	end
	
    respond_to do |format|
      if @entry.save
        format.html { redirect_to user_entry_path(@user, @entry), :notice => 'Entry was successfully created.' }
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @entry = @user.entries.find(params[:id])
	
	@entry.status = "Pending"
	@entry.system_list = ""
	@systems = params[:systems]
	@systems.each do |s|
		@entry.system_list.add(s)
	end	
	
	@entry.comp_list = ""
	@components = params[:components]
	@components.each do |c|
		@entry.comp_list.add(c)
	end
	
    respond_to do |format|
      if @entry.update_attributes(params[:id])
        format.html { redirect_to user_entry_path(@user, @entry), :notice => 'Entry was successfully updated.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @entry = @user.entries.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to(user_entries_url(@user)) }
      format.xml  { head :ok }
    end
  end
end
