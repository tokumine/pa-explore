class Track < ActiveRecord::Base
  belongs_to :user
  has_many :classifications
  has_many :cells, :through => :classifications
  attr_accessible :started_at, :finished_at, :user
end
