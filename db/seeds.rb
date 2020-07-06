#use Faker gem to generate fake data
#Example:
# User.create(name: Faker::Name.name)
# Restaurant.create(name: Faker::Company.name)
# Review.create(user_id: User.all.sample.id, restaurant_id: Restaurant.all.sample.id, content: Faker::Hacker.say_something_smart)

# User.destroy_all
# Userresource.destroy_all
# Resource.destroy_all


#user data User.create(username: ,password: ,name: ,age:  ,borough: ,user_id: )
#should we use a username or user_id?
user1 = User.create(username: "username_1", password: "username_1", name: "Sarah", age: 27, borough: "Brooklyn", user_id: 12)
#Faker::Name.name

#userresource data Userresource.create(username: , user_id, resource_id)
#for user_id, you could assign the attribute user_id = user.id OR user: name
ur1 = Userresource.create(user_id: u1.id, resource: r1.id)


#resource data Resource.create(resource_id, name:, location:, zipcode: ,url:)
r1 = Resource.create(resource_id: 1, name: "myTherapyNYC" , location: " 928 Broadway, Suite 405/806, NYC 10010" , zipcode: "10010", url: "https://mytherapynyc.com/")

puts "done seeding!"