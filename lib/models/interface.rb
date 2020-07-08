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

    def main_menu
        system "clear"
        puts "Welcome to the NYC Mental Health Services App!"
        self.prompt.select("What would you like to do?") do |menu|
            menu.choice "Create a new search", -> {Resource.new_search}
            menu.choice "View saved resources", -> {self.view_saved_userresource} #another way to name class methods?
            menu.choice "Delete a saved resource", -> {self.delete_userresource}
            menu.choice "Logout", -> {self.logout}
        end
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

    # def new_search
    #     #system "clear"
    #     puts "New Search"
    #     self.prompt.select("Please select a Borough to search by:") do |menu|
    #          menu.choice "Brookyln", -> {Resource.search}
    #          menu.choice "Bronx", -> {Resource.search}
    #          menu.choice "Manhattan", -> {Resource.search}
    #          menu.choice "Queens", -> {Resource.search}
    #          menu.choice "Staten Island", -> {Resource.search}
    #          menu.choice "Return to the Main Menu", -> {self.search}
    #       end
    # end


#     #self.view_saved_userresource
#     def view_saved_userresource
#         system "clear"
#         user.view_saved_userresource()
#         main_menu
#     end


#     #self.delete_userresource

#     def self.logout
#         puts "Thank you. Please come again"
#         exit!
#     end

# #Userresource
#         #returning user can [view userresources, create a new search]
#             #if view userresources -> display a list of saved resources 
#                 #returning user can view, delete or create a new search 
                    
#             #if create a new search -> 
#                 #location -> user is prompted to choose a borough
#                 #then user is prompted to choose a practicioner 
#                      #returns resources list  
#                      #new user can view, save or delete search result
#                          #creates a new search
#                          #end session 
#                              #goodbye message        
