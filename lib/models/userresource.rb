class Userresource < ActiveRecord::Base
    belongs_to :users
    has_many :resources

    # def self.view_saved_resources
        
    # end

end