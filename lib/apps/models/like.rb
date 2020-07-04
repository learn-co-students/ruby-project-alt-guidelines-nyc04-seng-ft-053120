class Like < ActiveRecord::Base
    belongs_to :joke, through: :user
    belongs_to :comment, through: :user
end