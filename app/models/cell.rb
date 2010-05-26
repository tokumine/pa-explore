class Cell < ActiveRecord::Base
  has_many :classifications
  has_many :tracks, :through => :classifications
  attr_accessible :positive_count, :negative_count, :x, :y, :z, :parent_x, :parent_y, :parent_z
end
