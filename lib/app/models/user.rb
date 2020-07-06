class User < ActiveRecord::Base
  has_many :collaborations
  has_many :projects, through: :collaborations
  has_many :tasks
  
  def change_username(new_username)
    self.username = new_username
    self.save
  end

  def create_new_project(name, description)
    new_project = Project.create(name: name, description: description)
    new_project.save
    new_collaboration = Collaboration.create(user: self, project: new_project)
    new_collaboration.save
    new_ownership = Ownership.create(user: self, project: new_project)
    new_ownership.save
    new_project
  end
end