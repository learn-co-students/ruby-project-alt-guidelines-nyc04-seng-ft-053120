class Project < ActiveRecord::Base
    has_many :tasks
    has_many :collaborations
    has_many :users, through: :collaborations
    has_one :ownership
    has_one :user, through: :ownership

    def change_name(new_name)
        self.name = new_name
        self.save
    end
end