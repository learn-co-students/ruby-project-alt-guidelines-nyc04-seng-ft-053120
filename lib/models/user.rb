class User < ActiveRecord::Base
    has_many :reviews
    has_many :books, through: :reviews


    def self.try_again
        prompt = TTY::Prompt.new
        if prompt.select("Would you like to try again?", %w(Yes No)) == "No"
            puts "-------Exiting app--------"
            exit
        end
    end

    def self.create_new_user
        prompt = TTY::Prompt.new
        puts "------------------\nLets get to know you better"
        input = prompt.collect do
            key(:name).ask("What is your name?:")
            key(:age).ask("How old are you?:")
            key(:display_name).ask("Create a cool display name:")
        end
        #loops until it does not find a match
        until !User.find_by(display_name: input[:display_name])
            puts "\nSorry #{input[:name]}, that display name has been taken"
            self.try_again
            input[:display_name] = prompt.ask("Create a display name:")
        end
        #creates user with their input
        User.create(name: input[:name], age: input[:age], display_name: input[:display_name])
    end  

    def self.logging_someone_in
        prompt = TTY::Prompt.new
        display_name = prompt.ask("Insert your display name:")
        until found_user = User.find_by(display_name: display_name)
            puts "\nDisplay name does not exist"
            self.try_again
            display_name = prompt.ask("What is your a display name:")
        end
        found_user
    end
end