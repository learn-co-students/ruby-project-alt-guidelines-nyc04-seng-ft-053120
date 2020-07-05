class User < ActiveRecord::Base
    has_many :comments
    has_many :minions
    has_many :like
end