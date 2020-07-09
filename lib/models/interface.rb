class Interface
    attr_accessor :prompt, :user

    def initialize
        @prompt = TTY::Prompt.new
    end

#Outputs a Welcome message to user 
  def greeting
        puts "Welcome to the NYC Mental Resources App!"
    end

# #Asks user if [new user, returning user] 
#     if new user -> user creates an account
#         new user enters username, password, name, age, and borough
#             attributes meets integer/string requirements OR user is prompt to reenter

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
    
#Userresource
        #new user prompted to create a new search based on location
            #location -> user is prompted to choose a borough
            #then user is prompted to choose a practicioner 
                 #returns resources list  
                 #new user can view, save or delete search result
                     #creates a new search
                     #end session 
                        #goodbye message 
    def main_menu
        system "clear"
        puts "Welcome, #{user.username}"
        prompt.select("What would you like to do?") do |menu|
            menu.choice "Create a new search", -> {self.create_new_userresource}
            menu.choice "View saved resources", -> {self.view_saved_userresource} #another way to name class methods?
            menu.choice "Delete a saved resource", -> {self.delete_userresource}
            menu.choice "Logout", -> {self.logout}
        end
    end

    #self.new_search
    def new_search
        system "clear"
        self.prompt.select("Please select a Borough to search by:") do |menu|
            menu.choice "Brookyln", -> {Resources.borough}
            menu.choice "Bronx", -> {Resources.borough}
            menu.choice "Manhattan", -> {Resources.borough}
            menu.choice "Queens", -> {Resources.borough}
            menu.choice "Staten Island", -> {Resources.borough}
            menu.choice "Main Menu"
        end
    end

    

    def create_new_userresource
        borough_name = Resource.new_search
        provider = Resource.provider(borough_name)
        record = Resource.create_record(provider)
        puts "Your record has been created"
        main_menu
    end

    #self.view_saved_userresource
    def view_saved_userresource
        system "clear"
        user.view_saved_userresource()
        main_menu
    end
    #self.delete_userresource

    def self.logout
        puts "Thank you. Please come again"
        exit!
    end

 #User                       
    #if returning user -> user signs in using username and password
        #returning user inputs username and password
        #verifies if username and password combo is correct
             #if not correct-prompts user to reenter username or password again
            
             #if correct - logs returning user in 

#Userresource
        #returning user can [view userresources, create a new search]
            #if view userresources -> display a list of saved resources 
                #returning user can view, delete or create a new search 
                    
            #if create a new search -> 
                #location -> user is prompted to choose a borough
                #then user is prompted to choose a practicioner 
                     #returns resources list  
                     #new user can view, save or delete search result
                         #creates a new search
                         #end session 
                             #goodbye message        
end