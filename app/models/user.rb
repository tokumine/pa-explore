class User < ActiveRecord::Base
  acts_as_authentic
  has_many :tracks
  
  def refresh_stats
    cx = Classifications.count :joins => [:tracks => :users], 
                               :conditions => "value != nil AND user_id = #{self.id}"    
    meters_explored = cx * APP_CONFIG[:meters_per_cell]
    save
    refresh_rank
  end
  
  
  #do some fancy shit here
  def refresh_rank
    self.rank = User.count(:conditions => "meters_explored > #{meters_explored}") + 1
    above = User.find_by_rank rank+1
    if meters_explored > above.meters_explored
      rank = above.
      above.update_attribute(:rank, above.rank-1) if above.rank > 0
      save
    end
    neighbours = neighbours - self    
  end
end
