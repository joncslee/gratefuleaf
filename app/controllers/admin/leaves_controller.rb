class Admin::LeavesController < ApplicationController
  def index
    @leaves = Leaf.all
  end

  def show
    @leaf = Leaf.find(params[:id])
  end

  def new
    @leaf = Leaf.new
  end

  def create
    @leaf = Leaf.new(params[:leaf])
    if @leaf.save
      redirect_to [:admin, @leaf], :notice => "Successfully created leaf."
    else
      render :action => 'new'
    end
  end

  def edit
    @leaf = Leaf.find(params[:id])
  end

  def update
    @leaf = Leaf.find(params[:id])
    if @leaf.update_attributes(params[:leaf])
      redirect_to [:admin, @leaf], :notice  => "Successfully updated leaf."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @leaf = Leaf.find(params[:id])
    @leaf.destroy
    redirect_to admin_leaves_url, :notice => "Successfully destroyed leaf."
  end
end
