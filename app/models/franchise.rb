class Franchise < ActiveRecord::Base
    belongs_to  :owner
    belongs_to :company
    end