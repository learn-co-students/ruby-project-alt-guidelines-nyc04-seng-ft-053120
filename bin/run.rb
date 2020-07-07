require 'pry'
require_relative '../config/environment'

#create a new franchise
def create_franchise
    puts "Please enter Company name:"
    company_name = gets.chomp
    company = Company.find_by name: company_name
    if company == nil
        company = Company.create({ :name => company_name })
    end

    puts "Please enter Owner name:"
    owner_name = gets.chomp
    owner = Owner.find_by name: owner_name
    if owner == nil
        owner = Owner.create({ :name => owner_name })
    end
#ask for location
    puts "What is the location?"
    location = gets.chomp

    Franchise.create({ 
        :profit => 0, 
        :location => location, 
        :owner_id => owner.id,
        :company_id => company.id
    })

    puts "Complete!"
end


def owner_and_franchises
    puts "Please enter owner name to see franchises:"
    owner_name = gets.chomp
    owner = Owner.find_by name: owner_name
    franchise = Franchise.find_by owner_id: owner.id
    company = Company.find_by id: franchise.company_id
    puts "This owner owns  #{company.name}"
end

#enter location to see profit
def location
    puts "Please enter location to see profit:"
    franchise_location = gets.chomp
    franchise = Franchise.find_by location: franchise_location
    puts "This location's profit is #{franchise.profit}"
end
