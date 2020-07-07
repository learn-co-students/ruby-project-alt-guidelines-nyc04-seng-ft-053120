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

#Userresource
        #new user prompted to create a new search based on location
            #location -> user is prompted to choose a borough
            #then user is prompted to choose a practicioner 
                 #returns resources list  
                 #new user can view, save or delete search result
                     #creates a new search
                     #end session 
                        #goodbye message 
    

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
                



    

  