class Resource < ActiveRecord::Base
    #has_many :userresources
    has_many :users, through: :userresources
    
    def self.new_search
        #system "clear"
        puts "New Search"
        
        # boroughs = self.all.map do |input|
        #     input.borough
        
        #borough finder
        found_boro = TTY::Prompt.new.select("Please select a Borough to search by:") do |menu|
            menu.choice "Brookyln"#, -> {self.brooklyn}
            menu.choice "Bronx"#, -> {self.search_by_practicioner}
            menu.choice "Manhattan"#, -> {self.search_by_practicioner}
            menu.choice "Queens"#, -> {self.search_by_practicioner}
            menu.choice "Staten Island"#, -> {self.search_by_practicioner}
            menu.choice "Return to the Main Menu"#, -> #{Interface.main_menu}
        end

        # found_borough = Resource.find_by(borough: found_boro)
        #     if found_borough
        #         return found_borough
        #     else
        #         puts "There are no practicioners in your Borough. Please try another Borough."
        # end
    end
end







                
    # #borough practicioners display
    # def self.find_by_borough(brooklyn)
    #     brooklyn_practicioners = self.all.select do |practicioner|
    #     practicioner.borough == "Brooklyn"
    #     end
    #     system "clear"
    #     puts " Here are your available practicioners in brooklyn:"
    #     puts""
    #     brooklyn_practicioners.map do |p|
    #         puts p.name
    #         puts""
    #     end
    # end
#system "clear"
    

    # def self.find_by_borough(b)
    #    # system "clear"
    #     puts "Borough Database Search"
    #     #go into the database and select all of the practicioners from that borough selected 
    #     x = self.all.select do |practicioner|
    #         practicioner.b == borough
    #         puts "search done"
    #     end


        # TTY::Prompt.new.select("Please select a Practicioner to search by:") do |menu|
        #     menu.choice "Psychologists"#, -> {self.search_by_practicioner}
        #     menu.choice "Psychiatrist"#, -> {self.search_by_practicioner}
        #     menu.choice "Social "#, -> {self.search_by_practicioner}
        #     menu.choice "Return to the Main Menu", -> {Interface.mai
