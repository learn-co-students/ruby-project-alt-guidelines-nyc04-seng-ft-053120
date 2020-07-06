class Task < ActiveRecord::Base
    belongs_to :project
    belongs_to :user
    
    def change_completed
<<<<<<< HEAD
        self.completed = true
        self.save
    end
  
    def change_due_date(new_due_date)
        self.due_date = new_due_date
        self.save
=======
      self.completed = true
      self.save
    end

    def change_due_date(new_due_date)
     self.due_date = new_due_date
     self.save
>>>>>>> ec7e5092224381df3cd293b831928af0b2deee15
    end
end