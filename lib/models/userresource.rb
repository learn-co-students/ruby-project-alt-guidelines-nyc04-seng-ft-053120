class Userresource < ActiveRecord::Base
    belongs_to :resources 
    belongs_to :user

    # def self.create_record(provider)
    #     #record = self.create(user_id: self.id, resource_id: provider.id, borough: provider[:borough], practitioner: provider[:practitioner] )
    #     new_ur = Userresource.create(user_id: self.id, resource_id: provider.id, borough:  provider[:borough], practitioner: provider[:practitioner])
    #     puts "Record created"
    #     record 
    # end
end