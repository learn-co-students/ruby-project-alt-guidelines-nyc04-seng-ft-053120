

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
        puts "Here are your orders!"
        orders.each do |order|
            puts "#{order} #{order.item.item_name}"
          end
        end
   
        def create_order
          item_names = Item.all.map do |item|
            {item.item_name => item}
          end
          item = TTY::Prompt.new.select("Choose an item", item_names)
          Order.create(customer_id: self.id, item_id: item.id)
          puts "Your order has been created for #{item.item_name}"
        end
   
        def update_order
          order_items= orders.map do |order|
            {order.item.item_name => order}
          end
          order= TTY::Prompt.new.select("Choose an order", order_items)
          new_items= Item.all.map do |item|
            {item.item_name => item}
          end
          new_item= TTY::Prompt.new.select("Choose an item", new_items)
          update_order=Order.find_by(id: order.id)
          update_order.item=new_item
          update_order.save
          puts "Your #{order} has been updated!"
        end
   
      def delete_order
        order_items= orders.map do |order|
          {order.item.item_name => order.id}
        end
        order_id= TTY::Prompt.new.select("Choose an order", order_items)
        Order.destroy(order_id)
        puts "Your order #{order_id} is deleted!"
      end
   
  
 end
 

