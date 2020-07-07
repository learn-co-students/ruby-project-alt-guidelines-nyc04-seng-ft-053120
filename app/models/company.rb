class Company < ActiveRecord::Base
    has_many :franchises
    has_many :owners, through: :franchises
end