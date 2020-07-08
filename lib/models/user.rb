class User < ActiveRecord::Base
    has_many :reviews
    has_many :books, through: :reviews

    #master
    def self.try_again
        prompt = TTY::Prompt.new
        if prompt.select("Would you like to try again?", %w(Yes No)) == "No"
            puts "-------Exiting app--------"
            exit
        end
    end 

    def self.create_new_user
        prompt = TTY::Prompt.new
        puts "------------------\nLets get to know you better"
        input = prompt.collect do
            key(:name).ask("What is your name?:")
            key(:age).ask("How old are you?:")
            key(:display_name).ask("Create a cool display name:")
        end
        #loops until it does not find a match
        until !User.find_by(display_name: input[:display_name])
            puts "\nSorry #{input[:name]}, that display name has been taken"
            self.try_again
            input[:display_name] = prompt.ask("Create a display name:")
        end
        #creates user with their input
        User.create(name: input[:name], age: input[:age], display_name: input[:display_name])
    end  

    def self.logging_someone_in
        prompt = TTY::Prompt.new
        display_name = prompt.ask("Insert your display name:")
        until found_user = User.find_by(display_name: display_name)
            puts "\nDisplay name does not exist"
            self.try_again
            display_name = prompt.ask("What is your a display name:")
        end
        found_user
    end

    def make_review
        prompt = TTY::Prompt.new
        input = prompt.collect do
            puts "\nBook Review"
            key(:title).ask("Enter Title of book:")
            key(:author).ask("Enter the Author's name:")
            key(:genre).ask("What is the genre of the book:")
            key(:comment).ask("Go ahead review away:")
            key(:rating).ask("On a scale of 1 - 10 how would rate the book?")
            key(:recommend).select("Do you recommend this book?", %w(Yes No))
        end

        Review.create(
            user_id: self.id,
            book_id: check_if_book_exist(input),
            comment: input[:comment],
            rating: input[:rating])
    end

    def check_if_book_exist(input)
        Book.all.each do |book|
            if ((input[:title] == book.title) && (input[:author] == book.author) && (input[:genre] == book.genre))
                return book.id
            end
        end
        return Book.create(
            title: input[:title],
            author: input[:author],
            genre: input[:genre]
            ).id
    end

    def delete_review(user_review)
        user_review.destroy
        puts "Your review is lost to the ether..."
    end
    
    def edit(user_reviews, num)
        prompt = TTY::Prompt.new
        choice = prompt.select("Choose a No. of the review you want to view", num)
        user_reviews[choice -= 1] 

        edit_or_delete = prompt.select("do want to Edit or Delete this review?", %w(edit delete))

        if edit_or_delete == "delete"
            delete_review(user_reviews[choice])
            my_reviews
        end

        input = prompt.collect do
            key(:attribute).select("What part of this review do you want to edit?", %w(comment rating))
            key(:user_changes).ask("Enter your new respose:")
        end

        if input[:attribute] == "comment"
            user_reviews[choice].update(comment: input[:user_changes])
        elsif input[:attribute] == "rating" 
            user_reviews[choice].update(rating: input[:user_changes])
        end
    end

    def my_reviews
        prompt = TTY::Prompt.new
        user_reviews = User.find_by(id: self.id).reviews
        if user_reviews == []
            puts "You have no reviews, how sad"
            self.main_menu
        end
        i = 0
        num = []
        array_to_print = []
        user_reviews.each do |review|
            num << i += 1
            array_to_print << ["#{i}", review.book.title, review.book.author, review.book.genre, review.comment, review.rating]
        end
        print_table(array_to_print)
        edit(user_reviews, num)
    end


    def print_table(array_to_print)
        prompt = TTY::Prompt.new
        reviews_table = TTY::Table.new ["No. ", "Title", "Auththor", "Genre", "Comment", "Rating"], [[],[]], array_to_print
        puts reviews_table.render(:unicode, alignments: [:center, :center], padding: [0,1,0,1])
    end

    
end
