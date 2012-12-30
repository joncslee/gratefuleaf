class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
   
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @user }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      render :action => 'show'
    else
      render :action => 'edit'
    end
  end
end
