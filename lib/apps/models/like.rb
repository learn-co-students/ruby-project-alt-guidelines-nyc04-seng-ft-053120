class Like < ActiveRecord::Base
    belongs_to :joke
    belongs_to :comment
end