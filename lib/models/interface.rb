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
        # if user.name == nil 
        #     return exit 
        # end
        puts "Welcome to Book Club #{user.name}!"
        answer = prompt.select("What would you like to do?") do |menu|
            menu.choice "Search for reviews", -> {self.see_all_books}
            menu.choice "Review a book", -> {}
            menu.choice "Edit or delete a review", -> {}
            menu.choice "Log out", -> {}
        end
    end

    def see_all_books
        user.display_books
        main_menu
    end




end   