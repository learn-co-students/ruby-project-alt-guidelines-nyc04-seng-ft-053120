class User < ActiveRecord::Base
    has_many :reviews
    has_many :books, through: :reviews

    def self.create_new_user
        prompt = TTY::Prompt.new 
        username = prompt.ask("Create a username:")
        until !User.find_by(name: username)
            puts "Sorry, that username has been taken"
            prompt = TTY::Prompt.new
            username = prompt.ask("Create a username:")
        end
        User.create(name: username)
    end  

    def self.logging_someone_in
        prompt = TTY::Prompt.new
        username = prompt.ask("Insert your username:")
        find_user = User.find_by(name: username)
        if find_user
            return find_user 
        else 
            puts "Sorry, that name does not exist."
            self.logging_someone_in
        end
    end


  



    # def self.quit
    #     puts "Thank you for visiting us!"
    #     system('exit')
    # end
end 

    #    def display_reviews
    #     book_reviews = self.reviews.map do |review|
    #         review.comment
    #     end 
    #     if book_reviews.lenght > 0
    #         TTY::Prompt.new("Reviews:", book_reviews)
    #     else 
    #         puts "There are no reviews for this book. Be the first to create a review for it!"
    #     end
    # end


    # def display_books
    #     all_books = self.books.map do |book_instance|
    #         {book_instance.title => book_instance.id }
    #     end 
    #     if all_books.length > 0
    #         TTY::Prompt.new.select("Choose a book", all_books)
    #     else 
    #         puts "You don't habe any books available 😢"
    #     end
    # end
