class User < ActiveRecord::Base
    has_many :transactions
    has_many :items, through: :transactions

    @@prompt=TTY::Prompt.new

    def self.user_menu(user)
        system("clear")
        puts""
        puts"           Choose your window?            "
        @@prompt.select("",active_color: :green) do |w|
            w.choice "          Donator", -> {user.donator_menu}
            w.choice "          Requester", ->{}     #waiting for tracy to name it...
            w.choice "          Log Out".cyan, ->{Interface.login_signup} #0
            w.choice "          Quit".red, -> {Interface.quit}  #1
        end
        binding.pry
        return nil
    end

    def donator_menu
        system("clear")
        puts""
        puts "          Donator's Main Menu          "
        @@prompt.select("",active_color: :green) do |m|
            m.enum "."
            m.choice "          Make a Donation", -> {Item.add_item(self)}  #2
            m.choice "          Cancel a Donation", -> {self.cancel_donation} #3
            m.choice "          Update quantity", -> {self.update_quantity}#4
            m.choice "          View all my Donations", -> {self.view_donations}
            m.choice "          Previous menu",-> {self.class.user_menu(self)}
            m.choice "          Quit".red, ->{Interface.quit}
        end
        return nil
    end






end