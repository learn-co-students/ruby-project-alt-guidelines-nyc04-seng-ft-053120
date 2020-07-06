#interacts and gets info/data from user
class Interface 
    attr_accessor :prompt, :user
    
    def initialize
        @prompt = TTY::Prompt.new
    end

    

    def welcome
        puts "

       .--.           .---.        .-.
   .---|--|   .-.     | B |  .---. |~|    .--.
.--|===|We|---|_|--.__| O |--|:::| |~|-==-|==|---.
|%%|HI!|lc|===| |~~|To| O |--|   |_|~|CLUB|BY|___|-.📚
|  |   |om|===| |==|  | K |  |:::|=| |    |::|---|=|📚
|  |   |e~|   |_|__|  |   |__|   | | |    |RK|___| |📚
|~~|===|--|===|~|~~|%%|~~~|--|:::|=|~|----|==|---|=|📚
^--^---'--^---^-^--^--^---'--^---^-^-^-==-^--^---^-'📚

"
    end

    def choose_login_or_register
        prompt.select("Log in or register?") do |menu|
            menu.choice "Log In", -> { User.logging_someone_in }
            menu.choice "Register", -> { User.create_new_user }
        end
    end

    def main_menu
        puts "Welcome to Book Club #{user.name}!"
        answer = prompt.select("What would you like to do?") do |menu|
            menu.choice "Search for reviews", -> {}
            menu.choice "Review a book", -> {}
            menu.choice "Edit my review", -> {}
            menu.choice "Log out", -> {}
        end
    end

    # def main_menu
    #     puts "Welcome to Book Club #{user.name}!"
    # end
end   