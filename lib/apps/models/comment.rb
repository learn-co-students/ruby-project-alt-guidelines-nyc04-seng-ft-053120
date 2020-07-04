class Comment < ActiveRecord::Base
    belongs_to :joke
    belongs_to :user
    belongs_to :lesson
end