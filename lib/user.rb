class User < ActiveRecord::Base
    has_many :reviews
    has_many :books, through: :reviews


    def self.create_new_user
        prompt = TTY::Prompt.new 
        username = prompt.ask("Create a username:")
        until !User.find_by(name: username)
            puts "Sorry, that username has been taken"
            prompt = TTY::Prompt.new
            username = prompt.ask("Create a username:")
        end
        User.create(name: username)
    end  

    def self.logging_someone_in
        prompt = TTY::Prompt.new
        username = prompt.ask("Insert your username:")
        find_user = User.find_by(name: username)
        if find_user
            return find_user 
        else 
            puts "Sorry, that name does not exist."
            return exit 
        end
    end
end