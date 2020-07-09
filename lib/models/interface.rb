require_relative './user.rb'
class Interface
    attr_accessor :prompt, :user

    def initialize
        @prompt = TTY::Prompt.new
    end

    def greeting
        puts "Welcome to the NYC Mental Resources App!"
    end

    def new_user_or_returning_user
        answer = prompt.select("Are you a returning user or a new user?", [
                "New User",
                 "Returning User"
             ])
            if answer == "New User"
                User.create_new_user
                elsif answer == "Returning User"
                User.returning_user
        end
    end
    
    def main_menu
        system "clear"
        puts "Welcome to the NYC Mental Services App #{User.current_user.name}!"
        prompt.select("What would you like to do?") do |menu|
            menu.choice "Create a new search", -> {Resource.new_search}
            menu.choice "View saved resources", -> {self.view_saved_userresource} #another way to name class methods?
            menu.choice "Delete a saved resource", -> {self.delete_userresource}
            menu.choice "Logout", -> {self.logout}
        end
    end

    def new_search
        system "clear"
        self.prompt.select("Please select a Borough to search by:") do |menu|
            menu.choice "Brookyln", -> {Resources.borough}
            menu.choice "Bronx", -> {Resources.borough}
            menu.choice "Manhattan", -> {Resources.borough}
            menu.choice "Queens", -> {Resources.borough}
            menu.choice "Staten Island", -> {Resources.borough}
            menu.choice "Main Menu", -> {main_menu}
        end
    end

    def create_new_userresource
        borough_name = Resource.new_search
        provider = Resource.provider(borough_name)
        record = Userresource.create_record(provider)
        puts "Your record has been created"
        main_menu
    end

    # def view_saved_userresource
    #     system "clear"
    #     user.view_saved_userresource()
    #     main_menu
    # end

    # #self.delete_userresource

    # def self.logout
    #     puts "Thank you. Please come again"
    #     exit!
    # end
end