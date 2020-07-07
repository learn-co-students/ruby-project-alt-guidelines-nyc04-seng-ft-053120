class Owner < ActiveRecord::Base
    has_many :franchises
    has_many :companies, through: :franchises
end