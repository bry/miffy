require 'rubygems'
require 'gosu'
require 'yaml'

class MyWindow < Gosu::Window

  MAIN_IMAGE_PIXEL_WIDTH = 425
  MAIN_IMAGE_PIXEL_HEIGHT = 625

  GIFT_BOX_X_POSITION = 200
  GIFT_BOX_Y_POSITION = 200

  CAKE_X_POSITION = 300
  CAKE_Y_POSITION = 500

  def cake_x_position
    CAKE_X_POSITION
  end

  def cake_y_position 
    CAKE_Y_POSITION
  end

  def gift_box_x_position 
    GIFT_BOX_X_POSITION
  end

  def gift_box_y_position 
    GIFT_BOX_Y_POSITION
  end

  def grabbed_giftbox=(grabbed_giftbox)
    @grabbed_giftbox = grabbed_giftbox    
  end

  def grabbed_giftbox
    @grabbed_giftbox
  end

  def grabbed_cake=(grabbed_cake)
    @grabbed_cake = grabbed_cake    
  end

  def grabbed_cake
    @grabbed_cake
  end  

  def initialize

    super(MAIN_IMAGE_PIXEL_WIDTH, MAIN_IMAGE_PIXEL_HEIGHT, false)

    # Load MyWindow images, and music from config  
    read_config(self)   

    @grabbed_giftbox = false  
    @grabbed_cake = false
    @background_music.play

    @miffy = Miffy.new(self)
    @miffy.warp(0,0)
    @direction = "down"
  end

  def read_config(window)
    # For MyWindow instance variable names, see miffy_config.yaml keys
    config = YAML.load_file("./config/miffy_config.yaml")

    # MyWindow attributes
    self.caption = config["main_window_config"]["window_title_bar_caption"]

    # Window images with single tiles
    config["main_window_images"].each { |key, value| instance_variable_set("@#{key}", 
    Gosu::Image.new(window, value, false)) }      

    # Window music
    config["music"].each { |key, value| instance_variable_set("@#{key}", 
    Gosu::Sample.new(self, value)) }     
  end    

  def update

    if (button_down? Gosu::KbLeftShift or button_down? Gosu::KbRightShift) and button_down? Gosu::KbRight then
      @miffy.moverightfast
      @direction = :right

    elsif (button_down? Gosu::KbLeftShift or button_down? Gosu::KbRightShift) and button_down? Gosu::KbLeft then
      @miffy.moveleftfast
      @direction = :left

    elsif (button_down? Gosu::KbLeftShift or button_down? Gosu::KbRightShift) and button_down? Gosu::KbUp then
      @miffy.moveupfast
      @direction = :up

    elsif (button_down? Gosu::KbLeftShift or button_down? Gosu::KbRightShift) and button_down? Gosu::KbDown then
      @miffy.movedownfast
      @direction = :down  

    elsif button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @miffy.moveleft
      @direction = :left 

    elsif button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @miffy.moveright
      @direction = :right

    elsif button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @miffy.moveup
      @direction = :up

    elsif button_down? Gosu::KbDown or button_down? Gosu::GpDown then
      @miffy.movedown
      @direction = :down

    elsif button_down? Gosu::KbP then
      @direction = "happybirthday"   

    elsif button_down? Gosu::KbH then
      @direction = "heart"   

    elsif button_down? Gosu::KbL then
      @direction = "ily"   

    elsif button_down? Gosu::KbN then
      @direction = "nerds"  

    elsif button_down? Gosu::KbC then
      @direction = "iamcute" 

    elsif button_down? Gosu::KbS then
      @direction = "iamsmart"            

    elsif button_down? Gosu::KbW then
      @direction = "iamsweet"             
    end

    @miffy.check_gift_grab
    @miffy.check_cake_grab
  end

  def draw

    @background_image.draw(0,0,0)

    if !@grabbed_giftbox then
      @image_giftbox.draw(GIFT_BOX_X_POSITION,GIFT_BOX_Y_POSITION,0)          
    end

    if !@grabbed_cake then
      @image_miffy_cake.draw(CAKE_X_POSITION,CAKE_Y_POSITION,0)
    else
      @image_anna.draw(0,0,0)
    end

    @miffy.draw(@direction)
  end
end
