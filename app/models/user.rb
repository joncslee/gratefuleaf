class User < ActiveRecord::Base
  has_merit

  acts_as_authentic
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :avatar

  has_many :leaves
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  extend FriendlyId
  friendly_id :username, use: :slugged

  def has_avatar
    avatar.url != '/avatars/original/missing.png'
  end

  def daily_leaves
    self.leaves.created_today
  end

  def weekly_leaves
    self.leaves.created_this_week
  end

end
