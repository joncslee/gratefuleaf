class Admin::BadgesController < ApplicationController
  def index
    @badges = Badge.all
  end

  def show
    @badge = Badge.find(params[:id])
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new(params[:badge])
    if @badge.save
      redirect_to [:admin, @badge], :notice => "Successfully created badge."
    else
      render :action => 'new'
    end
  end

  def edit
    @badge = Badge.find(params[:id])
  end

  def update
    @badge = Badge.find(params[:id])
    if @badge.update_attributes(params[:badge])
      redirect_to [:admin, @badge], :notice  => "Successfully updated badge."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @badge = Badge.find(params[:id])
    @badge.destroy
    redirect_to admin_badges_url, :notice => "Successfully destroyed badge."
  end
end
