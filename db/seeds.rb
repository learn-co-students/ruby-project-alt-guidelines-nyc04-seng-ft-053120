Customer.destroy_all
Item.destroy_all
Order.destroy_all

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


puts 'Done Seeding!'