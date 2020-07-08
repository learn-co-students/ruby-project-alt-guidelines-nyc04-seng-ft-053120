class User < ActiveRecord::Base
    has_many :resources, through: :userresources 


    #self.create_new_user
    def self.create_new_user
        prompt = TTY::Prompt.new
        user = prompt.ask("What do you want your username to be?")
        pass = prompt.ask("What do you want your password to be?")
        name = prompt.ask("Enter your first name:")
        age = prompt.ask("How old are you?")
        boro = prompt.select("What borough do you live in?") do |menu|
            menu.choice 'Brooklyn'
            menu.choice 'Bronx'
            menu.choice 'Manhattan'
            menu.choice 'Staten Island'
            menu.choice 'Queens'
            end

        User.create(username: user, password: pass, age: age, borough:boro)
        puts "Welcome #{user}, name #{name}, living in #{boro} we hope you find what you need! :sunglasses:"
    end
    

    #self.returning_user
    def self.returning_user
    prompt = TTY::Prompt.new 
    username_of_the_user = prompt.ask("Please enter your username:")
    password_of_the_user = prompt.ask("Please enter your password:")
    found_user = User.find_by(username: username_of_the_user, password: password_of_the_user)
         if found_user
             return found_user
         else
             puts " Sorry, that username and password combo is incorrect. Please reenter."
        end
    end
end

