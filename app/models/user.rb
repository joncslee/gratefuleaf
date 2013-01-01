class User < ActiveRecord::Base
  has_merit

  acts_as_authentic
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :avatar

  has_many :leaves
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def has_avatar
    avatar.url != '/avatars/original/missing.png'
  end

end
