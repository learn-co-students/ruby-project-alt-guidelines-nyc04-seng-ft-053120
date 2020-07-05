class Lesson < ActiveRecord::Base
    has_many :likes, through: :users
    has_many :comments, through: :users
end