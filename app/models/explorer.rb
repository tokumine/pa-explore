#Core movement class

class Explorer
  attr_accessor :x, :y, :z, :total_cells, :max_axis, :distance

  class Loc < Hashie::Dash
    property :x
    property :y
    property :z, :default => 17
  end
    
  def initialize track, opts = {}
    opts.reverse_merge! :z => 17
    opts.reverse_merge! :x => rand(2**opts[:z]), 
                        :y => rand(2**opts[:z]), 
                        :distance => APP_CONFIG[:cells_per_track]
    @loc          = Loc.new :x => opts[:x], :y => opts[:y], :z => opts[:z]
    @distance     = opts[:distance]    
    @total_cells  = (2**@loc.z)**2
    @max_axis     = 2**@loc.z
    @path         = []    
    @track        = track
    survey    
  end
  

  def explore!
    return if @distance == 0
    move
    survey
    explore!
  end
  
  # GAME SPACE
  # . ^ .
  # < y >
  # . v .
  # 
  # move to the cell with lowest number of surveys (on average)
  # avoid getting into loops (don't go to a cell where you touch own path)
  #
  # . v . . . .   
  # . v . . . .
  # . v < < . .
  # . v . ^ . .
  # . > > ^ . .
  #
  # if cell with nothing, go there first.
  #
  def move
    # Choose a random cell
    # JAVI: Extend this part of the method to chose cell with lower number of surveys (on average)
    cell = cells_around(@loc).rand
    
    # If new cell is in path, or if touches path aside from current cell, no move.
    # This prevents the explorer from getting in to a dead end
    # And also helps to generates straighish tracks
    bad_path = cells_around(cell, :include_self => true) - [@loc] #<-- it's ok to touch current cell      
        
    if (bad_path - @path) == bad_path
      @path << cell
      @loc = cell
      @distance -= 1      
    end  
          
    #cells = Cell.all :conditions => "(x = #{@x-1} AND y = #{@y}) OR (x = #{@x+1} AND y = #{@y}) OR (x = #{@x} AND y = #{@y-1}) OR (x = #{@x} AND y = #{@y+1})",
    #                 :order => "positive_count + negative_count ASC"
    
    # if all the cells have already been surveyed, weight index to those with few surveys                 
    #if cells.size == 4
    #  i = rand(3)
    #  i = (i - (i * 0.1)).floor      
    #  @x = cells[i].x
    #  @y = cells[i].y
    #  return
    #end
    
    # if there are empty cells, make a new cell where there's a gap and use that 
 #[@x, @y-1] *<-- ALWAYS GOING DOWN
    #existing_cells = cells.map {|c| [c.x, c.y]}
    #survey_cell = (possible_cells - existing_cells).rand
  end
  
  
  #survey a cell
  def survey
    cell = Cell.find_or_create_by_x_and_y_and_z(@loc.x, @loc.y, @loc.z)
    @track.classifications.create(:cell => cell, :x => cell.x, :y => cell.y, :z => cell.z)
  end    
 
  
  # HELPER generate array of surrounding cells
  def cells_around cell, opts = {}
    opts.reverse_merge! :include_self => false
    
    ca = [Loc.new(:x => cell.x+1, :y => cell.y),
          Loc.new(:x => cell.x-1, :y => cell.y),
          Loc.new(:x => cell.x, :y => cell.y+1),
          Loc.new(:x => cell.x, :y => cell.y-1)]
    
    # add self if requested
    ca << cell if opts[:include_self]
        
    ca
  end  
end