class Explorer
  attr_accessor :x, :y, :z, :total_cells, :max_axis, :distance
    
  def initialize opts = {}
    opts.reverse_merge! :z => 17
    opts.reverse_merge! :x => 2**opts[:z], :y => 2**opts[:z], :distance => APP_CONFIG[:cells_per_track]
    @x, @y, @z, @distance = opts[:x], opts[:y], opts[:z], opts[:distance]    
    @total_cells, @max_axis, @path = (2**@z)**2, 2**@z, []
    @path = []    
    @current_cell = Cell.find_or_create_by_x_and_y_and_z(loc[:x],loc[:y],loc[:z])
  end
  
  def explore
    return if @distance == 0
    move
    explore
  end
  
  def move
    @current_cell.north
    classifications.create(:cell => cell, :x => cell.x, :y => cell.y, :z => cell.z)
  end
    
  def location
    {:x => @x, :y => @y, :z => @z}
  end
end