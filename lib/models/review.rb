class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :book

    def self.create_new_review
    
    end  

    def display_reviews
        book_reviews = self.reviews.map do |review|
            review.comment
        end 
        if book_reviews.lenght > 0
            TTY::Prompt.new("Reviews:", book_reviews)
        else 
            puts "There are no reviews for this book. Be the first one and create a review for it!"
        end
    end

end