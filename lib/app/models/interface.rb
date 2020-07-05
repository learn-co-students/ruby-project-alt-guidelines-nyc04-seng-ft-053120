class Interface
  attr_accessor :prompt, :user

  def initialize
    @prompt = TTY::Prompt.new
  end

  def header
    system "clear"
    puts "
    ████████ ██     ██  ██████   ██████  ███████ ████████ ██   ██ ███████ ██████  
       ██    ██     ██ ██    ██ ██       ██         ██    ██   ██ ██      ██   ██ 
       ██    ██  █  ██ ██    ██ ██   ███ █████      ██    ███████ █████   ██████  
       ██    ██ ███ ██ ██    ██ ██    ██ ██         ██    ██   ██ ██      ██   ██ 
       ██     ███ ███   ██████   ██████  ███████    ██    ██   ██ ███████ ██   ██ 
                                                                                  
                                                                                  
    "
  end

  def log_in_page
    header
    puts "------------- Welcome to Twogether, A CLI Project Collaboration App -------------"
    puts 
    prompt.select("♥ SELECT AN OPTION: ") do |menu|
      menu.choice "Log In", -> { self.log_in }
      menu.choice "Register", -> { self.register }
    end
  end

  def log_in
    username_input = prompt.ask("\nEnter Username: ")
    user_found = User.find_by(username: username_input)
    if !user_found
      puts "Sorry, that username doesn't exist"
      prompt.select(" ") { |menu| menu.choice "Go Back", -> {self.log_in_page} }
    else
      @user = user_found
      puts "Log In Successful!"
      prompt.select(" ") { |menu| menu.choice "Go To Main Menu", -> {self.main_menu} }
    end
  end

  def register
    username_input = prompt.ask("Pick A Username: ")
    user_found = User.find_by(username: username_input)
    if user_found
      puts "Sorry, that username has been taken!"
      prompt.select(" ") { |menu| menu.choice "Go Back", -> {self.log_in_page} }
    else
      new_user = User.create(username: username_input)
      @user = new_user
      puts "Sign Up Successful!"
      prompt.select(" ") { |menu| menu.choice "Go To Main Menu", -> {self.main_menu} }
    end
  end

  def main_menu
    header
    puts "MAIN MENU"
    puts
    puts "♥ Welcome, #{user.username}. It's a great day to get some work done!"
    puts

    prompt.select("♥ Choose from the following options:\n") do |menu|
      menu.choice "View My Current Projects", -> { self.view_current_projects_page }
      menu.choice "Create a New Project", -> { self.create_a_new_project_page }
      menu.choice "Collaborate On An Existing Project", -> { self.collaborate_on_an_existing_project_page }
      menu.choice "Remove Myself From A Project", -> { self.remove_from_project_page }
      menu.choice "See Projects I Created\n", -> { self.projects_i_created_page }
      menu.choice "Log Out", -> { self.log_in_page }
    end
  end

  def create_a_new_project_page
    header
    puts "CREATE A NEW PROJECT"
    puts

    project_name_input = prompt.ask("♥ Enter new project's name: ")
    project_description_input = prompt.ask("♥ Enter a short description: ")

    new_project = user.create_new_project(project_name_input, project_description_input)
    puts "New project: #{new_project.name}, has been successfully created!"
    puts

    prompt.select(" ") do |menu|
      menu.choice "Add a Collaborator to My Project", -> { self.add_collaborator_page(new_project) }
      menu.choice "Take Me To Project Menu", -> { self.project_menu_page(new_project) }
      menu.choice "Go Back to Main Menu", -> { self.main_menu }
    end
  end

  def add_collaborator_page(new_project)
    header
    puts "ADD A COLLABORATOR"
    puts

    username_input = prompt.ask("Enter username of collaborator: ")
    collaborator = User.find_by(username: username_input) # will return nil if not found

    # If collaborator is already a collaborator on the project, puts message to tell user so
    if Collaboration.where(user: collaborator, project: new_project).exists?
      puts "This collaborator is already a part of this project!"
      promp.select(" ") do |menu|
        menu.choice "Try Another Collaborator", -> { self.add_collaborator_page(new_project) }
        menu.choice "Go Back to Main Menu", -> { self.main_menu }
      end
    elsif !collaborator # If collaborator cannot be found in database
      puts "The collaborator cannot be found."
      prompt.select(" ") do |menu|
        menu.choice "Try Another Collaborator", -> { self.add_collaborator_page(new_project) }
        menu.choice "Go Back to Main Menu", -> { self.main_menu }
      end
    elsif collaborator
      Collaboration.create(user: collaborator, project: new_project)
      puts "Collaborator, #{collaborator.username} has successfully been added to your project #{new_project.name}!"
      prompt.select(" ") do |menu|
        menu.choice "Add Another Collaborator", -> { self.add_collaborator_page(new_project) }
        menu.choice "Take me To Project Menu", -> { self.project_menu_page(new_project) }
        menu.choice "Go Back to Main Menu", -> { self.main_menu }
      end
    end
  end

  def view_current_projects_page
    # Displays all the current projects the user has
    header
    puts "VIEW ALL CURRENT PROJECTS"
    puts 
    
    choices = Hash.new
    user.projects.each { |project| choices[project.name] = project }
    project_selected = prompt.select("♥ Select a project:", choices)

    # Take the user to the project page
    project_menu_page(project_selected)

    ## Add option to take user back to home menu
  end

  def project_menu_page(project)
    # This displays info about a project
    header
    puts "PROJECT MENU - #{project.name}"
    puts project.description
    puts

    prompt.select("♥ Select from the following options: ") do |menu|
      menu.choice "See All Project Collaborators", -> { self.see_all_project_collaborators_page(project) }
      menu.choice "View All Project Tasks", -> { self.view_all_project_tasks_page(project) }
      menu.choice "View/Update My Tasks", -> { self.view_or_update_task_page(project) }
      menu.choice "Add a New Task\n", -> { self.add_a_new_task_page(project) }
      menu.choice "Go Back to View All Projects", -> { self.view_current_projects_page(project) }
      menu.choice "Go Back to Main Menu", -> { self.main_menu }
    end
  end

  def see_all_project_collaborators_page(project)
    # Displays all names of collaborators of a project
    header
    puts "ALL PROJECT COLLABORATORS - #{project.name}"
    puts
    project.users.each { |user| puts user.username }

    prompt.select("\n") do |menu|
      menu.choice "Go Back to Project Menu", -> { self.project_menu_page(project) }
      menu.choice "Go Back to Main Menu", -> { self.main_menu }
    end
  end

  def view_all_project_tasks_page(project)
    # Display all task name, completition status, user working on that task, and due date for all tasks in the project
    header
    puts "ALL PROJECT TASKS - #{project.name}"
    puts
    project.tasks.order(:due_date).each do |task|
      completion_status = "Not Yet!"
      completion_status = "Yep!" if task.completed
      puts "Task: #{task.description}"
      puts "Being Done By: #{task.user.username}"
      puts "Completed? #{completion_status}"
      puts "Due On: #{task.due_date.strftime("%m/%d/%Y")}"
      puts 
    end

    prompt.select("\n") do |menu|
      menu.choice "Go Back to Project Menu", -> { self.project_menu_page(project) }
      menu.choice "Go Back to Main Menu", -> { self.main_menu }
    end
  end

  def view_or_update_task_page(project)
    header
    puts "VIEW/UPDATE YOUR TASKS - #{project.name}"
    puts

    choices = Hash.new
    Task.where(user: user, project: project).each { |task| choices[task.description] = task }

    if choices.empty?
      puts "You don't have any task on this project right now."
      prompt.select("\n") do |menu|
        menu.choice "Add a New Task\n", -> { self.add_a_new_task_page(project) }
        menu.choice "Go Back to Project Menu", -> { self.project_menu_page(project) }
        menu.choice "Go Back to Main Menu", -> { self.main_menu }
      end
    else
      task_selected = prompt.select("♥ Select a task to edit or mark complete: ", choices)
      task_page(project, task_selected)
    end
    ## Add menu choices
  end

  def task_page(project, task)
    # Shows things user can do with a task
    header
    puts "#{task.description} - #{project.name}"
    puts

    prompt.select("♥ Select from the following: ") do |menu|
      menu.choice "Mark Completed", -> { self.mark_complete(task) }
      menu.choice "Edit Task", -> { self.edit(task) }
      menu.choice "Change Due Date\n", -> { self.change_due_date(task) }
      menu.choice "Go Back to View/Update Task Page", -> { self.view_or_update_task_page(project) }
      menu.choice "Go Back to Main Menu", -> { self.main_menu }
    end
  end

  def mark_complete(task)
    header
    task.change_completed
    puts "Task marked complete. Well done!"
    prompt.select("\n") do |menu|
      menu.choice "Go Back to View/Update Task Page", -> { self.view_or_update_task_page(project) }
      menu.choice "Go Back to Main Menu", -> { self.main_menu }
    end
  end

  def edit(task)
    header
    new_description = prompt.ask("Enter new description: ")
    task.description = new_description
    task.save
    puts "Task description updated!"

    prompt.select("\n") do |menu|
      menu.choice "Go Back to View/Update Task Page", -> { self.view_or_update_task_page(project) }
      menu.choice "Go Back to Main Menu", -> { self.main_menu }
    end
  end

  def change_due_date(task)
    header
    puts "♥ Enter new due date for task"

    month = (prompt.ask("Enter digit(s) month with no leading 0's: ")).to_i
    day = (prompt.ask("Enter digit(s) day with no leading 0's: ")).to_i
    year = (prompt.ask("Enter 4 digits year: ")).to_i

    new_date = Time.new(year, month, day)
    task.change_due_date(new_date)

    puts "Task due date updated!"

    prompt.select("\n") do |menu|
      menu.choice "Go Back to View/Update Task Page", -> { self.view_or_update_task_page(project) }
      menu.choice "Go Back to Main Menu", -> { self.main_menu }
    end
  end

  def add_a_new_task_page(project)
    # Add a new task for the user under this project
    header
    puts "ADD A NEW TASK - #{project.name}"
    puts
    task_description = prompt.ask("♥ Enter task description: ")
    puts 
    puts "♥ Enter a due date"
    month = (prompt.ask("Enter digit(s) month with no leading 0's: ")).to_i
    day = (prompt.ask("Enter digit(s) day with no leading 0's: ")).to_i
    year = (prompt.ask("Enter 4 digits year: ")).to_i
    task_due_date = Time.new(year, month, day)

    Task.create(description: task_description, completed: false, due_date: task_due_date, project: project, user: user)

    puts "Task successfully created!"

    prompt.select("\n") do |menu|
      menu.choice "Go Back to Project Menu", -> { self.project_menu_page(project) }
      menu.choice "Go Back to Main Menu", -> { self.main_menu }
    end
  end

  def collaborate_on_an_existing_project_page
    # This allows the user to add themselves as a collaborator on an existing project
    header
    puts "COLLABORATE ON AN EXISTING PROJECT"
    puts 
    project_name = prompt.ask("Enter project name: ")
    creator_name = prompt.ask("Enter username of project creator: ")
    project = Project.find_by(name: project_name)
    creator = User.find_by(username: creator_name)

    ownership_found = Ownership.where(user: creator, project: project)

    if ownership_found.empty?
      puts "This project doesn't exist!"
      prompt.select("\n") do |menu|
        menu.choice "Find Another Project to Collaborate", -> { self.collaborate_on_an_existing_project_page }
        menu.choice "Go Back to Main Menu", -> { self.main_menu }
      end
    elsif Collaboration.where(user: user, project: project).exist?
      puts "You're already a part of this project!"
      prompt.select("\n") do |menu|
        menu.choice "Find Another Project to Collaborate", -> { self.collaborate_on_an_existing_project_page }
        menu.choice "Go Back to Main Menu", -> { self.main_menu }
      end
    else
      Collaboration.create(user: self, project: project)
      puts "Nice! You are not a collaborator for #{project.name}!"
      prompt.select("\n") do |menu|
        menu.choice "Take Me to Project Menu", -> { self.project_menu_page(project) }
        menu.choice "Go Back to Main Menu", -> { self.main_menu }
      end
    end
  end

  def remove_from_project_page
    header
    puts "REMOVE MYSELF FROM A PROJECT"

    choices = Hash.new
    user.projects.each { |project| choices[project.name] = project }

    if choices.empty?
      puts "You're not a part of any project right now."
      prompt.select("\n") { |menu| menu.choice "Go Back to Main Menu", -> { self.main_menu } }
    else
      project_selected = prompt.select("Selector a project to stop collaborating: ", choices)

      collaboration = Collaboration.find_by(user: user, project: project_selected)
      puts "You're no longer a collaborator for #{project_selected.name}."
      collaboration.delete
      prompt.select("\n") { |menu| menu.choice "Go Back to Main Menu", -> { self.main_menu } }
  end

  def projects_i_created_page
    header
    puts "PROJECTS I CREATED"
    projects_owned = Project.select { |project| project.user == user }
    if projects_owned.empty?
      puts "You haven't created any project yet"
      prompt.select("\n") do |menu|
        menu.choice "Create a New Project", -> { self.create_a_new_project_page }
        menu.choice "Go Back to Main Menu", -> { self.main_menu }
      end
    else
      choices = Hash.new
      projects_owned.each { |project| choices[project.name] = project }
      projects_owned = prompt.select("♥ Select a project to go to page: ", choices)
      project_owner_page(project_selected)
    end
    # # Add option to go back to menu?
  end

  def project_owner_page(project)
    # displays the owner page for the project
    header
    puts "PROJECT I CREATED - #{project.name}"
    puts 
    prompt.select("♥ Select from the choices below: ") do |menu|
      menu.choice "Edit Project's Name", -> { self.edit_project_name_page(project) }
      menu.choice "Edit Project's Description", -> { self.edit_project_description_page(project) }
      menu.choice "See Collaborators", -> { self.see_all_project_collaborators_page(project) }
      menu.choice "Add a Collaborator\n", -> { self.add_collaborator_page(new_project) }
      menu.choice "Go Back to Main Menu", -> { self.main_menu }
    end

    def edit_project_name_page(project)
      header
      puts "EDIT PROJECT NAME - #{project.name}"
      puts
      new_name = prompt.ask("♥ Enter a new name for the project: ")
      project.name = new_name
      project.save
      puts "Project's name has been changed to '#{project.name}'"

      prompt.select("\n") do |menu|
        menu.choice "Go Back to Project Owner Page", -> { self.project_owner_page(project) }
        menu.choice "Go Back to Main Menu", -> { self.main_menu }
      end
    end

    def edit_project_description_page(project)
      new_description = prompt.ask("♥ Enter a new description for the project:")
      project.description = new_description
      project.save
      puts "Project's description has been changed to '#{project.description}'"

      prompt.select("\n") do |menu|
        menu.choice "Go Back to Project Owner Page", -> { self.project_owner_page(project) }
        menu.choice "Go Back to Main Menu", -> { self.main_menu }
      end
    end
  end
end