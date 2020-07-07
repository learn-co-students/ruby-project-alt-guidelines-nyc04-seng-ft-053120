User.destroy_all
Userresource.destroy_all
Resource.destroy_all
    

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychiatrist",
        location: Faker::Address.street_address,
        borough: "Brooklyn",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychologist",
        location: Faker::Address.street_address,
        borough: "Brooklyn",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Counselor",
        location: Faker::Address.street_address,
        borough: "Brooklyn",
        url: Faker::Internet.url
    )
end
    
5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychiatrist",
        location: Faker::Address.street_address,
        borough: "Manhattan",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychologist",
        location: Faker::Address.street_address,
        borough: "Manhattan",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Counselor",
        location: Faker::Address.street_address,
        borough: "Manhattan",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychiatrist",
        location: Faker::Address.street_address,
        borough: "Bronx",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychologist",
        location: Faker::Address.street_address,
        borough: "Bronx",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Counselor",
        location: Faker::Address.street_address,
        borough: "Bronx",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychiatrist",
        location: Faker::Address.street_address,
        borough: "Queens",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychologist",
        location: Faker::Address.street_address,
        borough: "Queens",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Counselor",
        location: Faker::Address.street_address,
        borough: "Queens",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychiatrist",
        location: Faker::Address.street_address,
        borough: "Staten Island",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Psychologist",
        location: Faker::Address.street_address,
        borough: "Staten Island",
        url: Faker::Internet.url
    )
end

5.times do
    Resource.create(
        name: Faker::Name.name,
        practitioner: "Counselor",
        location: Faker::Address.street_address,
        borough: "Staten Island",
        url: Faker::Internet.url
    )
end

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

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Brooklyn",
        practitioner: "Psychiatrist"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Brooklyn",
        practitioner: "Psychologist"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Brooklyn",
        practitioner: "Counselor"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Manhattan",
        practitioner: "Psychiatrist"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Manhattan",
        practitioner: "Psychologist"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Manhattan",
        practitioner: "Counselor"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Bronx",
        practitioner: "Psychiatrist"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Bronx",
        practitioner: "Psychologist"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Bronx",
        practitioner: "Counselor"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Queens",
        practitioner: "Psychiatrist"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Queens",
        practitioner: "Psychologist"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Queens",
        practitioner: "Counselor"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Staten Island",
        practitioner: "Psychiatrist"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Staten Island",
        practitioner: "Psychologist"
    )
end

5.times do
    Userresource.create(
        user_id: rand(1..10),
        resource_id: rand(1..10),
        borough: "Staten Island",
        practitioner: "Counselor"
    )
end

puts "done seeding!"