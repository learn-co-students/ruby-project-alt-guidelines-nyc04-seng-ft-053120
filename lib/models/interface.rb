class Interface 
    attr_accessor :prompt, :user

    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts " "
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
        puts " "
    end

    def choose_login_or_register
        prompt.select("Log in or register?") do |menu|
            menu.choice "Log In", -> { User.logging_someone_in }
            menu.choice "Register", -> { User.create_new_user }
            #menu.choice "Quit", -> { User.quit}
        end
    end

    def main_menu
        if user.name == nil 
            return exit 
        end
        system "clear"
        puts " "
        puts "Welcome to Book Club #{user.name}!"
        puts " "
        answer = prompt.select("What would you like to do?") do |menu|
            menu.choice "Search for reviews", -> { self.search_for_reviews }
            menu.choice "Create a review", -> {}
            menu.choice "Edit or delete a review", -> {}
            menu.choice "Log out", -> { self.goodbye }
        end
    end

    def search_for_reviews
        system "clear"
        puts " "
        answer = prompt.ask("Enter the book title:")
        book_instance = Book.all.find_by(title: answer)
        if book_instance
            self.get_book_reviews(book_instance)
        else 
            puts "That book has not been reviewed"
        end 
    end

    def get_book_reviews(book_instance)
        book_id = book_instance.id
        #user_id = 
        puts " "
        puts "These are the reviews for:"
        puts "\"#{book_instance.title}\""
        puts "By: #{book_instance.author}"
        puts " "

        reviews_array = Review.all.select {|rev| rev.book_id == book_id }
        reviews_array.each { |rev| 
                    puts "Comment: #{rev.comment}"
                    puts "Rating: #{rev.rating}"
        }

        #users_array = reviews_array.map {|rev| rev.user_id }
    
        
    end

    def goodbye
        system "clear"
        puts "Thank you for visiting Book Club! 📚 Come back soon!"
        # system('exit')
    end
end   