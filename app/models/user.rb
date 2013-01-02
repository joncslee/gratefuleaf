class User < ActiveRecord::Base
  has_many :leaves
  has_merit

  acts_as_authentic
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :avatar, :goal_type, :daily_leaf_goal, :weekly_leaf_goal

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

  # goal types: none, daily, or weekly
  NO_LEAF_GOAL = 0
  DAILY_LEAF_GOAL = 1
  WEEKLY_LEAF_GOAL = 2

end
