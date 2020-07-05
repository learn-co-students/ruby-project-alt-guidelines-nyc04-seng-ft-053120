# t.string "name"
# t.string "location"
# t.integer "net_worth"
# t.string "username"
# t.string "password"
def create_companies
  8.times do 
    Company.create(name: Faker::Company.unique.name, location: Faker::Address.city, net_worth: Faker::Number.number(digits 10), username: Faker::Alphanumeric.alpha(number: 6), password: Faker::Alphanumeric.alphanumeric(number: 6))
  end
end

# t.string "name"
# t.string "location"
# t.integer "net_worth"
def create_owners
  8.times do
    Owner.create(name: Faker::Name.unique.name, location: Faker::Address.city, net_worth: Faker::Number.number(digits: 8))
  end
end

# t.string "name"
# t.integer "company_id"
# t.integer "owner_id"
# t.string "location"
# t.integer "year_opened"
# t.integer "profit"
# t.boolean "open"
def create_franchises
  8.times do 
    Franchise.create(name: Faker::Company.unique.name, company_id: Company.all.sample.id, owner_id: Owner.all.sample.id, location: Faker::Address.city, date_opened: Faker::Date.between(from: "2010-01-01", to: "2020-01-01") , profit: Faker::Number.within(range = -1000.00..1000000.00), open: Faker::Boolean.boolean)
  end
end

create_companies

create_owners

create_franchises