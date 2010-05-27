class Classification < ActiveRecord::Base
  belongs_to :track
  belongs_to :cell
  attr_accessible :x, :y, :z, :value, :track, :cell
  acts_as_list :scope => :track
  after_update :update_stats
    
  def validate_on_update
    if changes["value"].first != nil
      errors.add(:value, "can't reclassify an existing classification")
    end  
  end
    
  def update_stats
    self.track.user.refresh_stats
    self.cell.update_totals :positive => value
  end  
end
