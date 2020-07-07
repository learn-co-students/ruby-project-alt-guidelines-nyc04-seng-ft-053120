Customer.destroy_all
Item.destroy_all
Order.destroy_all

#customer customer_name:
kelsey = Customer.create(customer_name:'Kelsey')
maria = Customer.create(customer_name:'Maria')

#items item_name:
phone = Item.create(item_name: "Phone")
laptop = Item.create(item_name: "Laptop")

#orders :customer_id,:item_id

Order.create(customer: kelsey, item: phone)
Order.create(customer: maria, item: phone)
Order.create(customer: maria, item: laptop)

puts "Done Seeding!"


