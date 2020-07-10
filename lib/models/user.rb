class User < ActiveRecord::Base
    belongs_to :userresources
    has_many :resources, through: :userresources 

    @@current_user = nil

    def self.current_user
        @@current_user
    end
    
    def self.create_new_user
        prompt = TTY::Prompt.new
        user = prompt.ask("What Would You Like Your Username To Be?")
        pass = prompt.ask("What Would You Like Your Password To Be?")
        name = prompt.ask("Please Enter Your First Name:")
        age = prompt.ask("Please Enter Your Age:")
        boro = prompt.select("What Borough Do You Live In?") do |menu|
            menu.choice 'Brooklyn'
            menu.choice 'Bronx'
            menu.choice 'Manhattan'
            menu.choice 'Staten Island'
            menu.choice 'Queens'
            end
        new_user = User.create(username: user, password: pass, age: age, borough:boro)
        @@current_user = new_user
    end
    
    def self.returning_user
    prompt = TTY::Prompt.new 
    username_of_the_user = prompt.ask("Please Enter Your Username:")
    password_of_the_user = prompt.ask("Please Enter Your Password:")
    found_user = User.find_by(username: username_of_the_user, password: password_of_the_user)
         if found_user
            @@current_user = found_user  
            return found_user
         else
             puts "Sorry, That Username And Password Combo Is Incorrect. Please Try Again."
        end
    end
end

