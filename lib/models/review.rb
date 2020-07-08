class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :book


    def self.search_for_reviews
        system "clear"
        prompt = TTY::Prompt.new
        puts " "
        answer = prompt.ask("Enter the book title:")
        book_instance = Book.all.find_by(title: answer)
        if book_instance
            self.get_book_reviews(book_instance)
        else 
            puts "That book has not been reviewed"
        end 
    end

    def self.get_book_reviews(book_instance)
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

end