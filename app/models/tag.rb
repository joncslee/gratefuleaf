class Tag < ActiveRecord::Base
  attr_accessible :leaf_id, :name
  belongs_to :leaf
end
