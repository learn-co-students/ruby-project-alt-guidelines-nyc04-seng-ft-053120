class Item < ActiveRecord::Base
    has_many :orders
    has_many :customers, through: :orders
<<<<<<< HEAD
    


   

end


=======
end
>>>>>>> efc8b8a504419dbd219b99baabae7c129d73a4cc
    