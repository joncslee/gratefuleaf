class Leaf < ActiveRecord::Base
  attr_accessible :content, :photo

  validates_presence_of :content

  belongs_to :user
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
