class Resource < ActiveRecord::Base
    #has_many :userresources
    has_many :users, through: :userresources
    has_many :userresources
    
    def self.new_search
        system "clear"
        puts "New Search"
        
        boroughs = self.all.map do |input|
            input.borough
        end
        
        #borough finder
        boro = TTY::Prompt.new.select("Please select a Borough to search by:") do |menu|
            menu.choice "Brookyln", -> {self.brooklyn}
            menu.choice "Bronx", -> {self.bronx}
            menu.choice "Manhattan", -> {self.manhattan}
            menu.choice "Queens", -> {self.queens}
            menu.choice "Staten Island", -> {self.statenisland}
            menu.choice "Return to the Main Menu", -> {Interface.main_menu}
        end
    end
    
    def self.brooklyn
        system "clear"
        puts ""
        arg = Resource.where(borough: "Brookyln")
        # puts "#{arg}"
        #arg.map do |a|
        puts "Here are the available practicioners in Brooklyn #{a}"
        #     #Resource.borough.all
       # arg.map do |doc|
          #puts ""
    end
end

#     def self.bronx
#         system "clear"
#             puts ""
#             arg = Resource.where(borough: "Bronx")
#             puts "Here are the available practicioners in Bronx"
#             arg.map do |doc|
#                 puts doc.name
#                 puts ""
#             end
#         end
#     end

#     def self.manhattan
#         system "clear"
#         puts ""
#         arg = Resource.where(borough: "Manhattan")
#             puts "Here are the available practicioners in Manhattan"
#         arg.map do |doc|
#             puts doc.name
#             puts ""
#         end
#     end

#     def self.queens
#         system "clear"
#         puts ""
#         arg = Resource.where(borough: "Queens")
#         puts "Here are the available practicioners in Queens"
#         arg.map do |doc|
#             puts doc.name
#             puts ""
#         end
#     end

#     def self.statenisland
#         system "clear"
#         puts ""
#         arg = Resource.where(borough: "Staten Island")
#         puts "Here are the available practicioners in Staten Island"
#         arg.map do |doc|
#             puts doc.name
#             puts ""
#         end
#     end
# end
        
    
        
        #bklyn
        # bklyn = Resource.find_by(borough: "Brooklyn")
        # return bklyn
    #         return found_borough
    #     # else
    #     #     puts "There are no practicioners in your Borough. Please try another Borough."
        
     
    








                
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
