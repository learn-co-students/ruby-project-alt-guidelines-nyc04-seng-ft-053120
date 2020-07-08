class Customer < ActiveRecord::Base
    has_many :orders
    has_many :items, through: :orders
    
     #asking user for username, checks to see if it already exists and returns welcome, or returns sorry, name doesnt exist. 
    def self.get_instance(username)
       get_instance = Customer.find_by(customer_name: username)
        if get_instance
            sleep(1)
            puts "Welcome #{username}!"
             get_instance
        else
            sleep(1)
            puts "Sorry! That name doesn't exist!"
        end
    end
      
     #Looking through Order class to return customer aka self
    def orders
          Order.where(customer: self)
    end
      
      #using method orders, to see how many orders the user has and then prints out the order instance and item name, 
      #otherwise if not orders returns sorry, no orders
      def view_order
        if orders.length > 0
            puts "You have #{orders.length} order(s)!"
        orders.each { |order| puts "#{order} #{ order.item.item_name }" }
        else
          puts "Sorry, you have no orders!"
        end
      end
      
      #choose_order checks to see if we have an order, allows us to pick our items associated with our id, if we dont have any items, returns sorry, no orders
    def choose_order
        if orders.length > 0
          order_items = orders.map { |order| { order.item.item_name => order.id } }
          TTY::Prompt.new.select("Choose an order:", order_items)
        else
          puts "Sorry, you have no orders!"
        end
      end

      #choose_item allows us to pick the item after choosing the order 
      
      def choose_item
        item_names = Item.all.map { |item| { item.item_name => item } }
        TTY::Prompt.new.select("Choose an item:", item_names)
      end

      #create_order takes the functionality from choose_item method and 
      #allows us to take the item selected by the user and create it, associating it with chosen_item & customer(self)
      def create_order
          chosen_item = choose_item
          create_order = Order.create(customer: self, item: chosen_item)
          puts "Your order #{create_order} is created!"
        end

        #update_order uses methods (choose_order) which allows user to see list of orders and choose 
        #them (choose_item) then updating that order with a new item, and saving while printing out to screen that the new item has been updated
        def update_order
            chosen_order_id = choose_order
            chosen_item = choose_item
            update_order = Order.find(chosen_order_id)
            update_order.item = chosen_item
            update_order.save
            puts "Your order #{chosen_order_id} is updated!"
        end
      
        #delete_order allows us to use the (choose_order) method and select the item we want to delete. Once Item is chosen, method returns the item that has been deleted
        def delete_order
          chosen_order_id = choose_order
          Order.destroy(chosen_order_id)
          puts "Your order #{chosen_order_id} is deleted!" 
      end
end