class Admin::RanksController < ApplicationController
  def index
    @ranks = Rank.all
  end

  def show
    @rank = Rank.find(params[:id])
  end

  def new
    @rank = Rank.new
  end

  def create
    @rank = Rank.new(params[:rank])
    if @rank.save
      redirect_to [:admin, @rank], :notice => "Successfully created rank."
    else
      render :action => 'new'
    end
  end

  def edit
    @rank = Rank.find(params[:id])
  end

  def update
    @rank = Rank.find(params[:id])
    if @rank.update_attributes(params[:rank])
      redirect_to [:admin, @rank], :notice  => "Successfully updated rank."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @rank = Rank.find(params[:id])
    @rank.destroy
    redirect_to admin_ranks_url, :notice => "Successfully destroyed rank."
  end
end
