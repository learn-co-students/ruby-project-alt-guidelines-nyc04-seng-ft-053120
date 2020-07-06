#use Faker gem to generate fake data
#Example:
# User.create(name: Faker::Name.name)
# Restaurant.create(name: Faker::Company.name)
# Review.create(user_id: User.all.sample.id, restaurant_id: Restaurant.all.sample.id, content: Faker::Hacker.say_something_smart)

# User.destroy_all
# Userresource.destroy_all
# Resource.destroy_all


#user data User.create(username: ,password: ,name: ,age: ,borough: )
user1 = User.create(username: "username_1", password: "username_1", name: "Sarah", age: 27, borough: "Brooklyn")
user2 = User.create(username: "username_2", password: "username_2", name: "Sarah", age: 25, borough: "Bronx")
user3 = User.create(username: "username_3", password: "username_3", name: "Sarah", age: 37, borough: "Manhattan")
user4 = User.create(username: "username_4", password: "username_4", name: "Sarah", age: 49, borough: "Queens")
user5 = User.create(username: "username_5", password: "username_5", name: "Sarah", age: 60, borough: "Staten Island")
user6 = User.create(username: "username_6", password: "username_6", name: "Sarah", age: 52, borough: "Brooklyn")
user7 = User.create(username: "username_7", password: "username_7", name: "Sarah", age: 48, borough: "Bronx")
user8 = User.create(username: "username_8", password: "username_8", name: "Sarah", age: 73, borough: "Manhattan")
user9 = User.create(username: "username_9", password: "username_9", name: "Sarah", age: 75, borough: "Queens")
user10 = User.create(username: "username_10", password: "username_10", name: "Sarah", age: 55, borough: "Staten Island")

#Faker::Name.name

# #userresource data Userresource.create(borough: ,practicioner:  ,user_id, resource_id)
# #for user_id, you could assign the attribute user_id = user.id OR user: name
# ur1 = Userresource.create(borough: , practicioner: , user_id: u1.id, resource: r1.id)


# #resource data Resource.create(resource_id, name:, location:, zipcode: ,url:)
# r1 = Resource.create(resource_id: 1, name: "myTherapyNYC" , location: "928 Broadway, Suite 405/806, NYC 10010" , zipcode: "10010", url: "https://mytherapynyc.com/")

puts "done seeding!"