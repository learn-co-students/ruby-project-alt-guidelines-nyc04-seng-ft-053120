User.destroy_all
Userresource.destroy_all
Resource.destroy_all


user1 = User.create(username: "Molly", password: "Dolly", name: "Holly", age: 27, borough: "Brooklyn")
user2 = User.create(username: "Shelly", password: "Smelly", name: "Belly", age: 25, borough: "Bronx")
user3 = User.create(username: "Ty", password: "Fly", name: "Blye", age: 37, borough: "Manhattan")


userresource_1 = Userresource.create(user_id: 123, resource_id: 234, borough: "Brooklyn", practitioner: "Dog" )
userresource_2 = Userresource.create(user_id: 124, resource_id: 456, borough: "Manhattan", practitioner: "Man" )
userresource_3 = Userresource.create(user_id: 125, resource_id: 789, borough: "Staten Island", practitioner: "She" )


resource_1 = Resource.create(name: "Dr. Sarah Glovesman", practitioner: "Psychologist", location: Faker::Address.street_address, borough: "Brooklyn", url: Faker::Internet.url )
resource_2 = Resource.create(name: "Dr. Rei Samuels", practitioner: "Psychiatrist", location: Faker::Address.street_address, borough: "Manhattan", url: Faker::Internet.url )
resource_3 = Resource.create(name: "Dr. Gene Williams", practitioner: "Social Worker", location: Faker::Address.street_address,  borough: "Bronx", url: Faker::Internet.url )
resource_5 = Resource.create(name: "Dr. Sam Glosman", practitioner: "Psychologist", location: Faker::Address.street_address, borough: "Queens", url: Faker::Internet.url )
resource_6 = Resource.create(name: "Dr. Robert Linden", practitioner: "Psychiatrist", location: Faker::Address.street_address, borough: "Brooklyn", url: Faker::Internet.url )
resource_7 = Resource.create(name: "Dr. Genesis Brown", practitioner: "Social Worker", location: Faker::Address.street_address, borough: "Manhattan", url: Faker::Internet.url )
resource_8 = Resource.create(name: "Dr. Rob G", practitioner: "Psychologist", location: Faker::Address.street_address, borough: "Bronx", url: Faker::Internet.url )
resource_9 = Resource.create(name: "Dr. Mike Khan", practitioner: "Psychiatrist", location: Faker::Address.street_address, borough: "Staten Island", url: Faker::Internet.url )
resource_10 = Resource.create(name: "Dr. Merritt Lubin", practitioner: "Social Worker", location: Faker::Address.street_address, borough: "Staten Island", url: Faker::Internet.url )


# 3.times do
#     Resource.create(
#         name: Faker::Name.name,
#         practitioner: "Psychiatrist",
#         location: Faker::Address.street_address,
#         borough: "Brooklyn",
#         url: Faker::Internet.url
#     )
#     Resource.create(
#         name: Faker::Name.name,
#         practitioner: "Psychologist",
#         location: Faker::Address.street_address,
#         borough: "Brooklyn",
#         url: Faker::Internet.url
#     )
#     Resource.create(
#         name: Faker::Name.name,
#         practitioner: "Counselor",
#         location: Faker::Address.street_address,
#         borough: "Brooklyn",
#         url: Faker::Internet.url
#     )
#     Userresource.create(
#         user_id: rand(1..10),
#         resource_id: rand(1..10),
#         borough: "Staten Island",
#         practitioner: "Psychiatrist"
#     )
#     Userresource.create(
#         user_id: rand(1..10),
#         resource_id: rand(1..10),
#         borough: "Staten Island",
#         practitioner: "Psychologist"
#     )
#     Userresource.create(
#         user_id: rand(1..10),
#         resource_id: rand(1..10),
#         borough: "Staten Island",
#         practitioner: "Counselor"
#     )
# end
 puts "done seeding :bug:" 

