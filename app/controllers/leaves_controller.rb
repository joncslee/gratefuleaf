class LeavesController < ApplicationController
  
  # only members have access to leaf sections
  before_filter :require_login

  def index
    @leaves = current_user.leaves
  end

  def new
    @leaf = Leaf.new
  end
  
  def show
    @leaf = Leaf.find(params[:id])
  end

  def create
    @leaf = current_user.leaves.create(params[:leaf])
    if @leaf.save
      flash[:notice] = "Leaf created successfully."
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def destroy
    @leaf = Leaf.find(params[:id])
    @leaf.destroy
    redirect_to leaves_url, :notice => "Successfully destroyed leaf."
  end

  private

  def require_login
    unless current_user
      redirect_to login_url
    end
  end

end
