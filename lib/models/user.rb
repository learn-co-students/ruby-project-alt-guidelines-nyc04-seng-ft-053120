class User < ActiveRecord::Base
    has_many :resources, through: :userresources 


    #self.create_new_user

    
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


#has_many- returns an array
#belongs_to- returns an instance

