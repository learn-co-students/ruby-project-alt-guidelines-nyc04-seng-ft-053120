class User < ActiveRecord::Base
    has_many :collaborations
    has_many :projects, through: :collaborations
    has_many :tasks
end