class Miffy

  # Miffy's constants
  TOP_BORDER_WALL_STOP_PIXEL_VALUE = -35
  LEFT_BORDER_WALL_STOP_PIXEL_VALUE = -15
  RIGHT_BORDER_WALL_STOP_PIXEL_VALUE = 350
  BOTTOM_BORDER_WALL_STOP_PIXEL_VALUE = 525

  MIFFY_FAST_SPEED = 4
  MIFFY_FAST_SPEED_IMAGE_CHANGE_X = MIFFY_FAST_SPEED * 3
  MIFFY_FAST_SPEED_IMAGE_CHANGE_Y = MIFFY_FAST_SPEED * 4

  TILE_SIZE_X = 100
  TILE_SIZE_Y = 100

  ANIMATION_STRIP_CELL_SIZE = 3

  def initialize(window)

    # Miffy tightly coupled with window 
    @window = window

    # Load Miffy's sweet, smart, and cute animations from config
    read_config(window)    

    @image_index = 0
    @dx_image_pixels = 10
    @d_pixel_count = 0

    @cake_x_border_left = @window.cake_x_position - 40
    @cake_x_border_right = @window.cake_x_position + 40
    @cake_y_border_up = @window.cake_y_position + 40
    @cake_y_border_down = @window.cake_y_position - 40

    @gift_x_border_left = @window.gift_box_x_position - 40
    @gift_x_border_right = @window.gift_box_x_position + 40
    @gift_y_border_up = @window.gift_box_y_position - 40
    @gift_y_border_down = @window.gift_box_y_position + 40

    # Miffy's starting position
    @x = @y = 0.0
  end

  def read_config(window)
    # For Miffy's instance variable names, see app_config.yaml keys
    config = YAML.load_file("./config/miffy_config.yaml")

    # Character images with multi-tiles
    config["character_movement_images"].each { |key, value| instance_variable_set("@#{key}", 
    Gosu::Image.load_tiles(window , value, TILE_SIZE_X, TILE_SIZE_Y, true) ) }

    # Character images with single tiles
    config["character_images"].each { |key, value| instance_variable_set("@#{key}", 
    Gosu::Image.new(window, value, false)) }        
  end

  def check_gift_grab
    if (@x > @gift_x_border_left and @x < @gift_x_border_right) and (@y > @gift_y_border_up and @y < @gift_y_border_down)
      @window.grabbed_giftbox = true    
    end
  end

  def check_cake_grab
    if (@x > @cake_x_border_left and @x < @cake_x_border_right) and (@y > @cake_y_border_down and @y < @cake_y_border_up)
      @window.grabbed_cake = true    
    end
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def moveup

    if @y < TOP_BORDER_WALL_STOP_PIXEL_VALUE then
      # Do nothing
    else
      @y -= 1

      if @y % @dx_image_pixels == 0 then
        @image_index = @image_index + 1
        @image_index = @image_index % ANIMATION_STRIP_CELL_SIZE      

        @d_pixel_count = @d_pixel_count + 1
        @d_pixel_count = @d_pixel_count % @dx_image_pixels
      end                 
    end
  end

  def moveupfast

    if @y < TOP_BORDER_WALL_STOP_PIXEL_VALUE then
      # Do nothing
    else
      @y -= MIFFY_FAST_SPEED

      if @y % MIFFY_FAST_SPEED_IMAGE_CHANGE_Y == 0 then
        @image_index = @image_index + 1
        @image_index = @image_index % ANIMATION_STRIP_CELL_SIZE      

        @d_pixel_count = @d_pixel_count + 1
        @d_pixel_count = @d_pixel_count % @dx_image_pixels
      end                 
    end
  end    

  def movedown

    if @y > BOTTOM_BORDER_WALL_STOP_PIXEL_VALUE
      # Do nothing
    else
      @y += 1

      if @y % @dx_image_pixels == 0 then
        @image_index = @image_index + 1
        @image_index = @image_index % ANIMATION_STRIP_CELL_SIZE      

        @d_pixel_count = @d_pixel_count + 1     
        @d_pixel_count = @d_pixel_count % @dx_image_pixels
      end
    end
  end

  def movedownfast

    if @y > BOTTOM_BORDER_WALL_STOP_PIXEL_VALUE
      # Do nothing
    else
      @y += MIFFY_FAST_SPEED

      if @y % MIFFY_FAST_SPEED_IMAGE_CHANGE_Y == 0 then
        @image_index = @image_index + 1
        @image_index = @image_index % ANIMATION_STRIP_CELL_SIZE      

        @d_pixel_count = @d_pixel_count + 1     
        @d_pixel_count = @d_pixel_count % @dx_image_pixels
      end
    end
  end    

  def moveleft

    if @x < -25
      # Do nothing    
    else

      @x -= 1

      if @x % @dx_image_pixels == 0 then
        @image_index = @image_index + 1
        @image_index = @image_index % ANIMATION_STRIP_CELL_SIZE      

        @d_pixel_count = @d_pixel_count + 1     
        @d_pixel_count = @d_pixel_count % @dx_image_pixels
      end 
    end
  end

  def moveleftfast

    if @x < -25
      # Do nothing    
    else

      @x -= MIFFY_FAST_SPEED

      if @x % MIFFY_FAST_SPEED_IMAGE_CHANGE_X == 0 then
        @image_index = @image_index + 1
        @image_index = @image_index % ANIMATION_STRIP_CELL_SIZE      

        @d_pixel_count = @d_pixel_count + 1     
        @d_pixel_count = @d_pixel_count % @dx_image_pixels
      end 
    end
  end    

  def moveright

    if @x > RIGHT_BORDER_WALL_STOP_PIXEL_VALUE then
      # Do nothing
    else

      @x += 1

      if @x % @dx_image_pixels == 0 then
        @image_index = @image_index + 1
        @image_index = @image_index % ANIMATION_STRIP_CELL_SIZE      

        @d_pixel_count = @d_pixel_count + 1     
        @d_pixel_count = @d_pixel_count % @dx_image_pixels
      end    
    end
  end

  def moverightfast

    if @x > RIGHT_BORDER_WALL_STOP_PIXEL_VALUE then
      # Do nothing
    else

      @x += MIFFY_FAST_SPEED

      if @x % MIFFY_FAST_SPEED_IMAGE_CHANGE_X == 0 then
        @image_index = @image_index + 1
        @image_index = @image_index % ANIMATION_STRIP_CELL_SIZE      

        @d_pixel_count = @d_pixel_count + 1     
        @d_pixel_count = @d_pixel_count % @dx_image_pixels
      end    
    end
  end    

  def draw(direction)      

    if @y > BOTTOM_BORDER_WALL_STOP_PIXEL_VALUE then
      @image_miffy_ouch.draw(@x,@y,0)    

    elsif @y < TOP_BORDER_WALL_STOP_PIXEL_VALUE then
      @image_miffy_alone_blood.draw(@x,@y,0)
      @image_ouch_bubble.draw(@x,(@y+TILE_SIZE_Y),0)

    elsif @x < LEFT_BORDER_WALL_STOP_PIXEL_VALUE then
      @image_miffy_left_blood.draw(@x,@y,0) 

    elsif @x > RIGHT_BORDER_WALL_STOP_PIXEL_VALUE then
      @image_miffy_right_blood.draw(@x,@y,0)    

      # Moving images
    elsif direction == :left then
      @images_left[@image_index].draw(@x,@y,0)

    elsif direction == :right then
      @images_right[@image_index].draw(@x,@y,0)

    elsif direction == :up then
      @images_up[@image_index].draw(@x,@y,0)

    elsif direction == :down then
      @images_down[@image_index].draw(@x,@y,0)

      # Message images
    elsif direction == "happybirthday" then
      @image_happy_birthday.draw(@x,@y,0)  

    elsif direction == "heart" then
      @image_heart.draw(@x,@y,0)

    elsif direction == "ily" then
      @image_ily.draw(@x,@y,0)

    elsif direction == "nerds"
      @image_nerds_coded_me.draw(@x,@y,0)

    elsif direction == "iamcute"
      @image_i_am_cute.draw(@x,@y,0)    

    elsif direction == "iamsmart"
      @image_i_am_smart.draw(@x,@y,0)

    elsif direction == "iamsweet"
      @image_i_am_sweet.draw(@x,@y,0)
    end
  end
end

