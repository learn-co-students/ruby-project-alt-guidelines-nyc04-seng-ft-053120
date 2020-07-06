class User < ActiveRecord::Base
    has_many :resources, through: :userresources 
end


#has_many- returns an array
#belongs_to- returns an instance

