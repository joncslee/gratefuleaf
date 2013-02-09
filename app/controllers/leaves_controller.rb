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


  def stats
    leaves = Leaf.count(
      :conditions => ["created_at >= ?", 14.days.ago],
      :group => "DATE(created_at)"
    )

    leaves_array = []
    14.downto(0) do |d|
      # Mon, 28 Jan 2013
      date = d.days.ago.strftime('%a, %d %b %Y').to_date
      leaves_array << (leaves[date] || 0)
    end


    @h = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:chart][:type] = "column"
      f.options[:chart][:inverted] = false
      f.options[:chart][:backgroundColor] = '#D0A34F'
      f.options[:legend][:enabled] = false
      f.options[:title][:text] = "Leaves in the Past 14 Days"
      f.options[:plotOptions] = {column: 
                                  {
                                    shadow: false, 
                                    borderWidth: 0, 
                                    pointInterval: 1.day, 
                                    pointStart: 14.days.ago
                                  }
                                }
      f.xAxis(:type => 'datetime', :labels => {:align => 'center'}, :dateTimeLabelFormats => { day: '%b %e' })
      f.yAxis(:title => {:text => 'Leaves'}, :allowDecimals => false, :gridLineWidth => 0, :lineWidth => 1)

      f.series(:name=>'Leaves', :data=>leaves_array, :color => '#426226')
    end
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
