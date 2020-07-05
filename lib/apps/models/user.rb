class User < ActiveRecord::Base
    has_many :comments
    has_many :minion
    has_many :like
end