class Leaf < ActiveRecord::Base
  belongs_to :user
  has_many :tags, :dependent => :destroy

  # named scopes for tracking the day's leaves and the week's leaves
  scope :created_today, lambda { where("created_at >= ? && created_at < ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day) }
  scope :created_this_week, lambda { where("created_on >= ? && created_on < ?", Date.today.beginning_of_week, Date.today.end_of_week) }

  attr_accessible :content, :photo

  validates_presence_of :content

  before_save :convert_links

  # after_save gets called multiple times because of associations
  after_commit :save_tags

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def has_photo
    photo.url != '/photos/original/missing.png'
  end

  # convert tags, links, and users into links
  def convert_links

    # fetch leaf content
    c = self.content

    # regexps
    # url = /( |^)http:\/\/([^\s]*\.[^\s]*)( |$)/
    tag = /( |^)#(\w+)( |$)/
    user = /( |^)@(\w+)( |$)/
    
    #replace #tags with links to that tag search
    while c =~ tag
      c.sub! "##{$2}", "<a href='/leaves?tagged=#{$2}'>##{$2}</a>"
    end

    #replace @usernames with links to that user, if user exists
    while c =~ user
      c.sub! "@#{$2}", "<a href='/users/#{$2}'>@#{$2}</a>"
    end

    #replace urls with links
    #while c =~ url
      #name = $2
      #c.sub! /( |^)http:\/\/#{name}( |$)/, " <a href='http://#{name}' >#{name}</a> "
    #end

    self.content = c

  end

  def save_tags
    # extract hashtags
    content.scan(/(?:\s|^|>)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$|<)/i) do |match|
      self.tags.create(:name => match.first)
    end
  end

end
