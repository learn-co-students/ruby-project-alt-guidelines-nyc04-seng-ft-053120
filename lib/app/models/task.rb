class Task < ActiveRecord::Base
    belongs_to :project
    belongs_to :user
    
    def change_completed
      self.completed = true
      self.save
    end

    def change_due_date(new_due_date)
     self.due_date = new_due_date
     self.save
    end
end