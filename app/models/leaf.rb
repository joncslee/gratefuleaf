class Leaf < ActiveRecord::Base
  belongs_to :user
  has_many :tags, :dependent => :destroy

  # named scopes for tracking the day's leaves and the week's leaves
  scope :created_today, lambda { { :conditions => ["created_at >= ? AND created_at < ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day] } }
  scope :created_this_week, lambda { { :conditions => ["created_on >= ? AND created_on < ?", Date.now.beginning_of_week, Date.now.end_of_week] } }
  
  
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
    tag_regex = /( |^)#(\w+)( |$)/
    user_regex = /( |^)@(\w+)( |$)/
    
    #TODO: make sure no one is typing javascript into the field **IMPORTANT**

    #replace #tags with links to that tag search
    while c =~ tag_regex
      c.gsub! "##{$2}", "<a href='/leaves?tagged=#{$2}'>##{$2}</a>"
      self.has_tags = true
    end

    #replace @usernames with links to that user, if user exists
    while c =~ user_regex
      user = $2
      if User.find(user)
        c.sub! "@#{$2}", "<a href='/users/#{$2}'>@#{$2}</a>"
      end
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
      # only create tags for this leaf if it is unique
      if self.tags.find_by_name(match.first).nil?
        self.tags.create(:name => match.first)
      end
    end
  end

end
