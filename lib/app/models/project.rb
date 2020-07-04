class Project < ActiveRecord::Base
    has_many :tasks
    has_many :collaborations
    has_many :users, through: :collaborations
    
end