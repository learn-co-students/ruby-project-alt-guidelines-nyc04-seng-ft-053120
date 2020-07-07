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
        puts " "
        prompt.select("Log in or register?") do |menu|
            menu.choice "Log In", -> { User.logging_someone_in }
            menu.choice "Register", -> { User.create_new_user }
        end
    end

    def main_menu
        system("clear")
        puts "Welcome to Book Club #{user.name}!"
        puts " "
        answer = prompt.select("What would you like to do?") do |menu|
            menu.choice "Search for reviews", -> { Review.search_for_reviews }
            menu.choice "Review a book", -> { user.make_review }
            menu.choice "Edit or delete a review", -> {}
            menu.choice "Log out", -> { self.logout }
        end
    end

    def logout
        system("clear")
        puts "Thanks for visiting us! Come back soon 📚"
    end


end   