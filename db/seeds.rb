User.destroy_all
Userresource.destroy_all
Resource.destroy_all
#User (username: password: name: age: borough: )
#Resource (name: practitioner: borough: url: )
#Userresource (user_id: resource_id: borough: practitioner: )
user1 = User.create(username: "Molly", password: "Dolly", name: "Holly", age: 27, borough: "Brooklyn")
user2 = User.create(username: "Shelly", password: "Smelly", name: "Belly", age: 25, borough: "Bronx")
user3 = User.create(username: "Ty", password: "Fly", name: "Blye", age: 37, borough: "Manhattan")
3.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychiatrist",
        location: Faker::Address.street_address,
        borough: "Brooklyn",
        url: Faker::Internet.url
    )
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychologist",
        location: Faker::Address.street_address,
        borough: "Brooklyn",
        url: Faker::Internet.url
    )
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Counselor",
        location: Faker::Address.street_address,
        borough: "Brooklyn",
        url: Faker::Internet.url
    )
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Staten Island",
        practitioner: "Psychiatrist"
    )
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Staten Island",
        practitioner: "Psychologist"
    )
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Staten Island",
        practitioner: "Counselor"
    )
end
puts "done seeding :bug:" 

