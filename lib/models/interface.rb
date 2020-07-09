class Interface
    attr_accessor :prompt, :customer
  
    def initialize
      @prompt = TTY::Prompt.new
    end
    
    #Display welcome message
    def welcome
        puts"               Welcome to"
        puts"                         ,--.          ,--."
        puts",--,--,--. ,--,--.,--.--.|  |,-. ,---. |  |"
        puts"|        |' ,-.  ||  .--'|     /| .-. :|  |"
        puts"|  |  |  |\ '-'  ||  |   |  \ \\   --. |  |"
        puts"`--`--`--' `--`--'`--'   `--'`--'`----'`--'"
    end

    #Get user input
    def user_input
      sleep(1)
      puts "Please enter your Markel username:"
      gets.chomp
    end
    
    #Get customer instance
    def get_instance
      username = user_input
      Customer.get_instance(username)
    end

    #Show menu
    def show_menu
      prompt.select("What would you like to do?") do |menu|
        menu.choice "Create Order", -> {self.create_order}
        menu.choice "View Order", -> {self.view_order}
        menu.choice "Update Order", -> {self.update_order}
        menu.choice "Delete Order", -> {self.delete_order}
        menu.choice "Exit", -> {self.exit}
    end
  end
  
  #Display customer's orders
  def view_order
    customer.view_order
    sleep(2)
    show_menu
  end

  #Customer creates an order
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

  #Customer deletes an order
  def delete_order
    customer.delete_order
    sleep(2)
    show_menu
  end
  
  #Customer exits the app
  def exit
    sleep(1)
    puts "Bye #{customer.customer_name}! Thanks for visiting!"
  end

end