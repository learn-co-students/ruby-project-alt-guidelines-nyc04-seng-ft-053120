class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :book

    def delete(user)
        
    end
end