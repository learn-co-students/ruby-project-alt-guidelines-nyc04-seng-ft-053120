class Resource < ActiveRecord::Base
    has_many :users, through: :userresources
    has_many :userresources
    
    @@boro 

    def self.new_search
        system "clear"
        puts "New Search"
        
        boroughs = self.all.map do |input|
            input.borough
        end
        
        @@boro = TTY::Prompt.new.select("Please Select A Borough To Search By:") do |menu|
            menu.choice "Brooklyn", -> {self.provider("Brooklyn")}
            menu.choice "Bronx", -> {self.provider("Bronx")}
            menu.choice "Manhattan", -> {self.provider("Manhattan")}
            menu.choice "Queens", -> {self.provider("Queens")}
            menu.choice "Staten Island", -> {self.provider("Staten Island")}
            menu.choice "Return to the Main Menu", -> {Interface.main_menu}
        end
    end
    
    def self.provider(borough_name)
        system "clear"
        #puts ""
        arg = Resource.all.select {|resource| resource[:borough] == borough_name}
        puts "Here Are The Available Practitioners In #{borough_name}"
        provider_names = arg.map do |provider|     
          {"#{provider[:name]} | #{provider[:practitioner]} | #{provider[:location]} | #{provider[:url]}" => provider.id}
        end    
        # if !provider_names.empty?     
        provider_id = TTY::Prompt.new.select('Select a provider', provider_names)      
        found_provider = Resource.all.find_by_id(provider_id)      
            found_provider  
        puts "Your Selection Has Been Saved To Your Saved Searches."

        return_to_main = TTY::Prompt.new.select('What Would You Like To Do Next?') do |menu|
            menu.choice "View Saved Searches"
            menu.choice "Return To The Main Menu"
            menu.choice "Logout", -> {self.logout}
        end
    end

    def self.logout 
        puts "Thank you. Please come again!"
    end

end
    

    # else
    #     puts 'No providers are available in your area'      
    #     sleep(4)    
    #end
   
        # menu_option = TTY::Prompt
    

    # def self.create_record(provider)
    #     #record = self.create(user_id: self.id, resource_id: provider.id, borough: provider[:borough], practitioner: provider[:practitioner] )
    #     new_ur = Userresource.create(user_id: self.id, resource_id: provider.id, borough:  provider[:borough], practitioner: provider[:practitioner])
    #     puts "Record created"
    #     record 
    # eend
