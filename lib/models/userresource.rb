class Userresource < ActiveRecord::Base
    belongs_to :users
    has_many :resources

end