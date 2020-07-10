require_relative './user.rb'
class Interface
    attr_accessor :prompt, :user

    def initialize
        @prompt = TTY::Prompt.new
    end

    def greeting
        puts "Welcome To The NYC Mental Resources App!"
    end

    def new_user_or_returning_user
        answer = prompt.select("Are You A Returning User Or A New User?", [
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
        puts "Welcome To The NYC Mental Health Resource Finder App #{User.current_user.name}!"
        prompt.select("What Would You Like To Do?") do |menu|
            menu.choice "Add A Free NYC Mental Health Practitioner To Account", -> {Resource.new_search}
            menu.choice "View Saved Resources", -> {self.view_saved_userresource} #another way to name class methods?
            menu.choice "Delete Saved Resources", -> {self.delete_userresource}
            menu.choice "Logout", -> {self.goodbye}
        end
    end

    def new_search
        system "clear"
        self.prompt.select("Please Select A Borough To Search By:") do |menu|
            menu.choice "Brookyln", -> {Resources.borough}
            menu.choice "Bronx", -> {Resources.borough}
            menu.choice "Manhattan", -> {Resources.borough}
            menu.choice "Queens", -> {Resources.borough}
            menu.choice "Staten Island", -> {Resources.borough}
            menu.choice "Main Menu", -> {main_menu}
        end
    end

    # def create_new_userresource
    #     borough_name = Resource.new_search
    #     provider = Resource.provider(borough_name)
    #     record = Userresource.create_record(provider)
    #     puts "Your Record Has Been Created"
    #     main_menu
    # end

    # def view_saved_userresource
    #     system "clear"
    #     user.view_saved_userresource()
    #     main_menu
    # end

    # #self.delete_userresource

    def self.goodbye
        puts "Thank you. Please come again"
    end
end