class Interface
    attr_accessor :prompt, :customer
     def initialize
      @prompt = TTY::Prompt.new
    end

    #displays welcome message 
     def welcome
        puts"               Welcome to".colorize(:magenta)
        puts"                         ,--.          ,--.".colorize(:light_blue)
        puts",--,--,--. ,--,--.,--.--.|  |,-. ,---. |  |".colorize(:light_blue)
        puts"|        |' ,-.  ||  .--'|     /| .-. :|  |".colorize(:light_blue)
        puts"|  |  |  |\ '-'  ||  |   |  \ \\   --. |  |".colorize(:light_blue)
        puts"`--`--`--' `--`--'`--'   `--'`--'`----'`--'".colorize(:light_blue)
    end

                                                                


    #get user input
    def user_input 
        sleep(1)
        puts "Please enter your Markel username:".colorize(:yellow).underline
        gets.chomp
    end
     
    #get customer instance 
    def get_instance
      username = user_input
      Customer.get_instance(username)
    end
  
    #show the menu 
    def show_menu
      prompt.select("What would you like to do?".colorize(:light_blue).underline) do |menu|
        menu.choice "Create Order".colorize(:yellow), -> {self.create_order}
        menu.choice "View Order".colorize(:yellow), -> {self.view_order}
        menu.choice "Update Order".colorize(:yellow), -> {self.update_order}
        menu.choice "Delete Order".colorize(:yellow), -> {self.delete_order}
        menu.choice "Exit".colorize(:white), -> {self.exit}
    end
  end
  
  #Displaying customer's orders
  def view_order
    customer.view_order
    sleep(2)
    show_menu
  end


  #Allows customer to create an order 
  def create_order
    customer.create_order
    sleep(2)
    show_menu
  end
  
  #Customer updates an order 
  def update_order
    customer.update_order
    sleep(2)
    show_menu
  end
  
  #customer deletes an order 
  def delete_order
    customer.delete_order
    sleep(2)
    show_menu
  end
  
  #Customer able to exit app
   def exit

    sleep(1)
    `say "Goodbye, thank you for shopping at Markel!"`
    puts "Bye #{customer.customer_name}! Thanks for visiting!".colorize(:magenta)
  end
  
 end
 