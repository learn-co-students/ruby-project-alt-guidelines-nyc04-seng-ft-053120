class Resource < ActiveRecord::Base
    has_many :users, through: :userresources
end