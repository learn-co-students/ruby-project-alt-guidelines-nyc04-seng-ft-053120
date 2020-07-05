class Task < ActiveRecord::Base
    belongs_to :project
    belongs_to :user
    def change_due_date(due_date)

    end
end