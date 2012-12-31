class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation

  has_many :leaves

end
