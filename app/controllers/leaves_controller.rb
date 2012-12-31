class LeavesController < ApplicationController
  
  # only members have access to leaf sections
  before_filter :require_login

  def index
    if request.post?
      @leaf = current_user.leaves.create(params[:leaf])
      if !@leaf.save
        redirect_to :action => 'new'
      end
    end
      
    @leaves = current_user.leaves
  end

  def new
    @leaf = Leaf.new
  end

  private

  def require_login
    unless current_user
      redirect_to login_url
    end
  end

end
