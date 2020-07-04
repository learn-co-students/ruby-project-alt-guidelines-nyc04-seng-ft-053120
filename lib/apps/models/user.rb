class User < ActiveRecord::Base
    has_many :comments
    has_and_belongs_to_many :minions
    has_many :like
end