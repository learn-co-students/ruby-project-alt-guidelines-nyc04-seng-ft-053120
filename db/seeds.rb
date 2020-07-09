Customer.destroy_all
Item.destroy_all
Order.destroy_all

<<<<<<< HEAD
#customer customer_name:
kelsey = Customer.create(customer_name:'Kelsey')
maria = Customer.create(customer_name:'Maria')
dickson = Customer.create(customer_name: "Dickson")
james = Customer.create(customer_name: "James")
alby = Customer.create(customer_name: "Alby")


#items item_name:
phone = Item.create(item_name: "Phone")
laptop = Item.create(item_name: "Laptop")
tv = Item.create(item_name: "TV")
washer = Item.create(item_name: "Washer")
dryer = Item.create(item_name: "Dryer")


#orders :customer_id,:item_id
=======
kelsey=Customer.create(customer_name: 'Kelsey')
maria=Customer.create(customer_name: 'Maria')
dickson=Customer.create(customer_name: 'Dickson')
james=Customer.create(customer_name: 'James')
alby=Customer.create(customer_name: 'Alby')

phone=Item.create(item_name: 'Phone')
laptop=Item.create(item_name: 'Laptop')
tv=Item.create(item_name: 'TV')
washer=Item.create(item_name: 'Washer')
dryer=Item.create(item_name: 'Dryer')
>>>>>>> efc8b8a504419dbd219b99baabae7c129d73a4cc

Order.create(customer: kelsey, item: phone)
Order.create(customer: maria, item: phone)
Order.create(customer: maria, item: laptop)
Order.create(customer: dickson, item: tv)
Order.create(customer: james, item: washer)
Order.create(customer: alby, item: dryer)
Order.create(customer: kelsey, item: tv)
Order.create(customer: dickson, item: washer)
Order.create(customer: james, item: phone)
Order.create(customer: alby, item: laptop)


<<<<<<< HEAD
puts "Done Seeding!"


=======
puts 'Done Seeding!'
>>>>>>> efc8b8a504419dbd219b99baabae7c129d73a4cc
