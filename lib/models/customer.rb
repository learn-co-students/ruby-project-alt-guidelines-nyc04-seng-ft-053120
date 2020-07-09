class Customer < ActiveRecord::Base
    has_many :orders
    has_many :items, through: :orders

    #Search username among customers and return customer
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

      #Search customer among orders and return array of customer's orders
      def orders
          Order.where(customer: self)
      end

      #Iterate over customer's orders and display each order
      def view_order
        if orders.length>0
          puts "You have #{orders.length} order(s)!"
          orders.each { |order| puts "Order #{order} is for #{order.item.item_name}" }
        else
          puts "Sorry, you have no orders!"
        end
      end

      #Option to choose an item from all items
      def choose_item
        item_names= Item.all.map { |item| {item.item_name => item} }
        TTY::Prompt.new.select("Choose an item:", item_names)
      end

      #Option to choose an order from customer's orders
      def choose_order
          order_item_names = orders.map { |order| {order.item.item_name => order} }
          TTY::Prompt.new.select("Choose an order:", order_item_names)
      end

        #Create order with the item chosen by customer
        def create_order
          chosen_item = choose_item
          create_order = Order.create(customer: self, item: chosen_item)
          puts "Your order #{create_order} is created for #{chosen_item.item_name}!"
        end

        #Update the order chosen by customer with the new item chosen by customer
        def update_order
          if orders.length>0
            chosen_order = choose_order
            chosen_item = choose_item
            update_order = Order.find(chosen_order.id)
            update_order.item = chosen_item
            update_order.save
            puts "Your order #{chosen_order} is updated with #{chosen_item.item_name}!"
          else
            puts "Sorry, you have no orders!"
          end
        end

      #Delete the order chosen by customer
      def delete_order
        if orders.length>0
          chosen_order = choose_order
          Order.destroy(chosen_order.id)
          puts "Your order #{chosen_order} for #{chosen_order.item.item_name} is deleted!" 
        else
          puts "Sorry, you have no orders!"
        end
      end
    
end
    