class Customer < ActiveRecord::Base
    has_many :orders
    has_many :items, through: :orders

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

      def orders
          Order.where(customer: self)
      end
    
      def view_order
        if orders.length>0
          puts "You have #{orders.length} order(s)!"
          orders.each { |order| puts "#{order} #{order.item.item_name}" }
        else
          puts "Sorry, you have no orders!"
        end
      end

      def choose_order
        if orders.length>0
          order_items = orders.map { |order| {order.item.item_name => order.id} }
          TTY::Prompt.new.select("Choose an order:", order_items)
        else
          puts "Sorry, you have no orders!"
        end
      end

      def choose_item
        item_names= Item.all.map { |item| {item.item_name => item} }
        TTY::Prompt.new.select("Choose an item:", item_names)
      end

      def create_order
          chosen_item = choose_item
          create_order = Order.create(customer: self, item: chosen_item)
          puts "Your order #{create_order} is created!"
        end
    
        def update_order
            chosen_order_id = choose_order
            chosen_item = choose_item
            update_order = Order.find(chosen_order_id)
            update_order.item = chosen_item
            update_order.save
            puts "Your order #{chosen_order_id} is updated!"
        end
    
      def delete_order
          chosen_order_id = choose_order
          Order.destroy(chosen_order_id)
          puts "Your order #{chosen_order_id} is deleted!" 
      end
    
end
    