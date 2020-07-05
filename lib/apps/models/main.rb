
class Main
    attr_accessor :prompt, :user

    def initialize
        @prompt = TTY::Prompt.new
    end

    # def welcome
    #     system('clear')
    #     window_l = ENV['COLUMNS'].to_i
    #     window_h = ENV['LINES'].to_i

    #     padding = (""*window_l).colorize(:background => :black)
    #     color_moon = {:color => :light_yellow, :background => :black}
    #     color_logo = {:color => :light_blue, :background => :black}
    #     small_art = [
    #         padding,
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         moon_logo1 ="a".center(window_l).colorize(color_logo),
    #         padding
    #     ]
    #     if window_l > 0 && window_l < 106
    #         small_art.each{|x| puts x}
    #     else
    #         puts "didn't work"
    #     end
    #     ((ENV['LINES'].to_i-2)/2-9).times do puts (" ")*window_l).colorize(:color => :light_yellow, :background => :black) end
    # end
    def welcome
        puts ' 
            ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░                                
            ░░░░▄██████████████████████▄░░░░                                 
            ░░░░█░░░░░░░░░░░░░░░░░░░░░░█░░░░                           
            ░░░░█░▄██████████████████▄░█░░░░                                                         
            ░░░░█░█░░░░░░░░░░░░░░░░░░█░█░░░░                            
            ░░░░█░█░░░░░░░░░░░░░░░░░░█░█░░░░                        
            ░░░░█░█░░█░░░░░░░░░░░░█░░█░█░░░░                
            ░░░░█░█░░░░░▄▄▄▄▄▄▄▄░░░░░█░█░░░░                        
            ░░░░█░█░░░░░▀▄░░░░▄▀░░░░░█░█░░░░                    
            ░░░░█░█░░░░░░░▀▀▀▀░░░░░░░█░█░░░░                        
            ░░░░█░█░░░░░░░░░░░░░░░░░░█░█░░░░                    
            ░█▌░█░▀██████████████████▀░█░▐█░                        
             _       _    _                  _       _    _               
            / /\    / /\ /\_\               / /\    / /\ /\_\             
           / / /   / / // / /         _    / / /   / / // / /         _   
          / /_/   / / / \ \ \__      /\_\ / /_/   / / / \ \ \__      /\_\ 
         / /\ \__/ / /   \ \___\    / / // /\ \__/ / /   \ \___\    / / / 
        / /\ \___\/ /     \__  /   / / // /\ \___\/ /     \__  /   / / /  
       / / /\/___/ /      / / /   / / // / /\/___/ /      / / /   / / /   
      / / /   / / /      / / /   / / // / /   / / /      / / /   / / /    
     / / /   / / /      / / /___/ / // / /   / / /      / / /___/ / /     
    / / /   / / /      / / /____\/ // / /   / / /      / / /____\/ /      
    \/_/    \/_/       \/_________/ \/_/    \/_/       \/_________/       
                                                                     
============================== a Netaly and Francisco production
            ░░░░░░░░██░░░░░░░░░░░░██░░░░░░░░
            ░░░░░░░░██░░░░░░░░░░░░██░░░░░░░░
            ░░░░░░░░██░░░░░░░░░░░░██░░░░░░░░
            ░░░░░░░▐██░░░░░░░░░░░░██▌░░░░░░░
            ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

'.blue.on_yellow
    end

    def login_register_prompt

    end

end