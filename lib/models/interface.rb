class Interface
    attr_accessor :prompt, :user

    def initialize
        @prompt = TTY::Prompt.new

    end
end

  # def greeting 
    #     puts "Welcome"
    #  end

    # #  def new_user_or_returning_user
    #     answer = prompt.select("Are you a new user or returning user?", [
    #         "New User", 
    #         "Returning User"
    #     ])
    #     if answer == "New User"
    #         User.create_new_user
    #     elsif answer == "Returning User"
    #         User.returning_user
    #     end

    #  end
# end



#Outputs a Welcome message to user 

#Asks user if [new user, returning user] 
    #if new user -> user creates an account
        #new user enters username, password, name, age, and borough
            #attributes meets integer/string requirements OR user is prompt to reenter

        #new user prompted to create a new search based on search criteria[location, practicioner]
            #if location -> user chooses a borough from a list of boroughs
                 #returns resources where resource.borough == borough selected in list format    
                 #new user can view individual search result
                 #new user can save the resource to userresource, create a new search, OR logout
                     #saves resource to userresource 
                     #creates a new search
                     #view userresources (saved resources)
                        #if and only if userresource.count > 0, display userresources list
                     #logs user out

            #if practicioner -> user chooses a praticioner from a list of praticioners
                #returns resources where resource.practicioner == practicioner selected in list format    
                 #new user can view individual search result
                 #new user can save the resource to userresource, create a new search, OR logout
                     #saves resource to userresource 
                     #creates a new search
                     #view userresources (saved resources)
                        #if and only if userresource.count > 0, display userresources list
                     #logs user out

    #if returning user -> user signs in using username and password
        #returning user inputs username and password
        #verifies if username and password combo is correct
             #if not correct-prompts user to enter username or password again
            
             #if correct - logs returning user in 
                
        #returning user can [view resources, create a new search]
            #if view resources -> display a list of saved resources 
                #returning user can select individual userresource from list
                #user can view userresource details
                    #delete resource from list
                    #user can return to back to userresources list 
                    
            #if create a new search -> 
                #returning user prompted to create a new search based on search criteria[location, practicioner]
                     #if location -> user chooses a borough from a list of boroughs
                         #returns resources where resource.borough == borough selected in list format    
                         #new user can view individual search result
                         #new user can save the resource to userresource, create a new search, OR logout
                            #saves resource to userresource 
                            #creates a new search
                            #view userresources (saved resources)
                                ##if and only if userresource.count > 0, display userresources list
                            #logs user out

                     #if practicioner -> user chooses a praticioner from a list of praticioners
                        #returns resources where resource.practicioner == practicioner selected in list format    
                        #new user can view individual search result
                        #new user can save the resource to userresource, create a new search, OR logout
                             #saves resource to userresource 
                             #creates a new search
                             #view userresources (saved resources)
                                #if and only if userresource.count > 0, display userresources list
                             #logs user out


    

  