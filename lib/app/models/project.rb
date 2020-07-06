class Project < ActiveRecord::Base
    has_many :tasks
    has_many :collaborations
    has_many :users, through: :collaborations
    has_one :ownership
    has_one :user, through: :ownership
    # attr_accessor :name, :description, :collaborations, :users, :tasks
    def change_name(new_name)
        self.name = new_name
        self.save
    end
    def change_description(new_description)
        self.description = new_description
        self.save
    end
end