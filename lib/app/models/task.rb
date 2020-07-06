class Task < ActiveRecord::Base
    belongs_to :project
    belongs_to :user
    # enum status: [:completed, :uncomplete]
    def change_completed()
      self.completed = true
    end
    def change_due_date(new_due_date)
     self.due_date = new_due_date
     self.save
    end
end