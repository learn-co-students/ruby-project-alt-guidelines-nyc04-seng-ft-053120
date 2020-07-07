class Book < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews 

    # def collect_book_reviews(book_instance)
    #     book_title = book_instance.collect { |book| book.title }
    #     book_comment = book_instance.collect { |book| book.comment}
    #     book_author = book_instance.collect { |book| book.author}
    #     puts " #{book_title}, #{book_comment}, #{book_author}"
    #     binding.pry
    #     puts "HI"
    # end

end