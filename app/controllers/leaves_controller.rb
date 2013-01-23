class LeavesController < ApplicationController

  # only members have access to leaf sections
  before_filter :require_login

  def index
    if params[:tagged]
      tags = Tag.where("name = ?", params[:tagged])
      @leaves = tags.map do |tag|
        tag.leaf
      end
    else
      @leaves = current_user.leaves.reverse
    end

    @leaves_by_day = @leaves.group_by { |leaf| leaf.created_at.beginning_of_day }
  end

  def new
    @leaf = Leaf.new
  end
  
  def show
    @leaf = Leaf.find(params[:id])
  end

  def create
    @leaf = current_user.leaves.new(params[:leaf])

    # extract user mentions
    mentions = []
    @leaf.content.scan(/(?:\s|^)(?:@(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i) do |match|
      mentions.push(match.first)
    end
    # TODO: do something with mentions

    Leaf.transaction do
      if @leaf.save
        # add points for successful creation!
        if @leaf.photo_file_name
          current_user.add_points(3)
        else
          current_user.add_points(2)
        end
        flash[:notice] = "Leaf created successfully."
        redirect_to :action => 'index'
      else
        render :action => 'new'
      end
    end
  end

  def destroy
    @leaf = Leaf.find(params[:id])

    if @leaf.photo_file_name
      current_user.substract_points(3)
    else
      current_user.substract_points(2)
    end

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
