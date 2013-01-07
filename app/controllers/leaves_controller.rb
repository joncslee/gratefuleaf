class LeavesController < ApplicationController

  # only members have access to leaf sections
  before_filter :require_login

  def index
    @leaves = current_user.leaves.reverse
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
        current_user.add_points(2)

        flash[:notice] = "Leaf created successfully."
        redirect_to :action => 'index'
      else
        render :action => 'new'
      end
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
