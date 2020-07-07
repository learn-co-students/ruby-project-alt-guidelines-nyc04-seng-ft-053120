class Interface
    attr_accessor :prompt, :customer
     def initialize
      @prompt = TTY::Prompt.new
    end
     def welcome
        puts"               Welcome to"
        puts"                         ,--.          ,--."
        puts",--,--,--. ,--,--.,--.--.|  |,-. ,---. |  |"
        puts"|        |' ,-.  ||  .--'|     /| .-. :|  |"
        puts"|  |  |  |\ '-'  ||  |   |  \ \\   --. |  |"
        puts"`--`--`--' `--`--'`--'   `--'`--'`----'`--'"
    end
     
    
    def get_instance
      sleep(1)
      puts "Please enter your Markel username:"
      username = gets.chomp
      Customer.get_instance(username)
    end
  
    def show_menu
      prompt.select("What would you like to do?") do |menu|
        menu.choice "Create Order", -> {self.create_order}
        menu.choice "View Order", -> {self.view_order}
        menu.choice "Update Order", -> {self.update_order}
        menu.choice "Delete Order", -> {self.delete_order}
        menu.choice "Exit", -> {self.exit}
    end
  end
  
  def view_order
    customer.view_order
    sleep(3)
    show_menu
  end
  
  def create_order
    customer.create_order
    sleep(3)
    show_menu
  end
  
  def update_order
    customer.update_order
    sleep(3)
    show_menu
  end
  
  def delete_order
    customer.delete_order
    sleep(3)
    show_menu
  end
  
   def exit
    puts "Thanks for visiting #{customer.customer_name}!"
  end
  
 end
 