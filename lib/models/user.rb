class User < ActiveRecord::Base
    has_many :reviews
    has_many :books, through: :reviews

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
            puts "Sorry, that display name has been taken"
            display_name = prompt.ask("Create a display name:")
        end
        #creates user with their input
        User.create(name: input[:name], age: input[:age], display_name: input[:display_name])
    end  

    def self.logging_someone_in
        prompt = TTY::Prompt.new
        display_name = prompt.ask("Insert your display_name:")
        find_user = User.find_by(display_name: display_name)
        if find_user
            return find_user 
        else 
            puts "Sorry, that name does not exist."
            self.logging_someone_in
        end
    end

    # def self.quit
    #     puts "Thank you for visiting us!"
    #     system('exit')
    # end
    
end 
