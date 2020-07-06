class User < ActiveRecord::Base
    has_many :collaborations
    has_many :projects, through: :collaborations
    has_many :tasks
    # attr_accessor :username, :collaborations, :projects, :tasks
    def change_username(new_username)
        self.username = new_username
        self.save
    end
    def create_new_project(name,description)
        new_project = Project.create(name: name, description: description)
        new_project.save
        new_collaboration = Collaboration.create(user: self, :project: new_project)
        new_collaboration.save
        new_ownership = Ownership.create(user: self, project: new_project)
        new_ownership.save
    end
    def collaborate(project)
       collaborate_project = Project.find_by(name: project.name)
          if collaborate_project == nil 
           puts" This project does not exist"
          else 
          Collaboration.create(user: self, project: project)  
          end
    end
    def add_new_task_to_project(description, due_date, project)
        found_project = Project.find(project.name)
        if found_project == true
        new_task = Task.create(user: self, description: description, completed: false, due_date: due_date, project: project)
        end
    end 
end