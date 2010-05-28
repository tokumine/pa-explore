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
    move    
  end
  
  def explore
    return if @distance == 0
    move
    explore
  end
  
  def move
    @current_cell.north
    
  end
  
  def survey
    cell = Cell.find_or_create_by_x_and_y_and_z(@x, @y, @z)
    @track.classifications.create(:cell => cell, :x => cell.x, :y => cell.y, :z => cell.z)
  end
    
  def location
    {:x => @x, :y => @y, :z => @z}
  end
end