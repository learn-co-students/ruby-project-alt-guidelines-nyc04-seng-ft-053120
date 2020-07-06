class Book < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews 

    def find_a_book
        Book.all.map{|book| book.title}
    end

end