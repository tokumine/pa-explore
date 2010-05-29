#Core movement class
class Explorer
  attr_accessor :x, :y, :z, :total_cells, :max_axis, :distance
    
  def initialize track, opts = {}
    opts.reverse_merge! :z => 17
    opts.reverse_merge! :x => rand(2**opts[:z]), 
                        :y => rand(2**opts[:z]), 
                        :distance => APP_CONFIG[:cells_per_track]
    @x            = opts[:x]
    @y            = opts[:y]
    @z            = opts[:z]
    @distance     = opts[:distance]    
    @total_cells  = (2**@z)**2
    @max_axis     = 2**@z
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
    survey_cell = [[@x+1, @y],[@x-1, @y],[@x+1, @y],[@x-1, @y],[@x, @y+1]].rand #[@x, @y-1] *<-- ALWAYS GOING DOWN
    #existing_cells = cells.map {|c| [c.x, c.y]}
    #survey_cell = (possible_cells - existing_cells).rand
    @x = survey_cell[0]
    @y = survey_cell[1]
  end
  
  #only survey a cell if you've not been there yet
  def survey
    cell = Cell.find_or_create_by_x_and_y_and_z(@x, @y, @z)

    if !@path.include? cell
      @track.classifications.create(:cell => cell, :x => cell.x, :y => cell.y, :z => cell.z)
      @path << cell       
      @x = cell.x
      @y = cell.y
      @distance -= 1
    end  
  end    
end