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

  def log_in_or_register_page
    # Welcome user and display choices for Log In or Register
    header
    puts "------------- Welcome to Twogether, A CLI Project Collaboration App -------------"
    puts 

    prompt.select("♥ SELECT AN OPTION: \n", cycle: true) do |menu|
      menu.choice "Log In", -> { log_in }
      menu.choice "Register", -> { register }
    end
  end

  def log_in
    # Prompt for username input, find username in database, if the username doesn't exist in the database, output message telling user so; if username is found, present choice to take user to main menu
    username_input = prompt.ask("\n♥ Enter Username: ")
    user_found = User.find_by(username: username_input)
    if !user_found
      puts "\nSorry, that username doesn't exist"
      prompt.select(" ") { |menu| menu.choice "Go Back", -> {log_in_or_register_page} }
    else
      @user = user_found
      puts "\nLog In Successful!"
      print "\nTaking you to main menu"
      4.times do |i|
        sleep(0.7)
        print(".")
      end
      main_menu
    end
  end

  def register
    # If the username is already in the database, puts message telling user so. Otherwise, take user to main menu.
    username_input = prompt.ask("\n♥ Pick A Username: ")
    user_found = User.find_by(username: username_input)
    if user_found
      puts "\nSorry, that username has been taken!"
      print "\nTaking you back to log in menu"
      4.times do |i|
        sleep(0.7)
        print(".")
      end
      log_in_or_register_page
    else
      new_user = User.create(username: username_input)
      @user = new_user
      puts "\nSign Up Successful!"
      print "\nTaking you to main menu"
      4.times do |i|
        sleep(0.7)
        print(".")
      end
      main_menu
    end
  end

  def main_menu
    # Displays options for user
    header
    puts "MAIN MENU"
    puts
    puts "♥ Welcome, #{user.username}. It's a great day to get some work done!"
    puts

    prompt.select("♥ Select an option:\n", cycle: true) do |menu|
      menu.choice "View My Current Projects", -> { view_current_projects_page }
      menu.choice "Create a New Project", -> { create_a_new_project_page }
      menu.choice "Collaborate On An Existing Project", -> { collaborate_on_an_existing_project_page }
      menu.choice "Remove Myself From A Project", -> { remove_from_project_page }
      menu.choice "See Projects I Created\n", -> { projects_i_created_page }
      menu.choice "Log Out", -> { log_in_or_register_page }
    end
  end

  def create_a_new_project_page
    header
    puts "CREATE A NEW PROJECT"
    puts

    project_name_input = prompt.ask("♥ Enter new project's name: ")
    project_description_input = prompt.ask("♥ Enter a short description: ")

    new_project = user.create_new_project(project_name_input, project_description_input)
    puts "\nNew project: \"#{new_project.name}\", has been successfully created!"
    puts

    prompt.select(" ", cycle: true) do |menu|
      menu.choice "Add a Collaborator to My Project", -> { add_collaborator_page(new_project) }
      menu.choice "Take Me To Project Menu", -> { project_menu_page(new_project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def add_collaborator_page(new_project)
    header
    puts "ADD A COLLABORATOR"
    puts

    username_input = prompt.ask("♥ Enter username of collaborator: ")
    collaborator = User.find_by(username: username_input) # will return nil if not found

    # If collaborator is already a collaborator on the project, puts message to tell user so
    if Collaboration.where(user: collaborator, project: new_project).exists?
      puts "\nThis collaborator is already a part of this project!"
      prompt.select(" ", cycle: true) do |menu|
        menu.choice "Try Another Collaborator", -> { add_collaborator_page(new_project) }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    elsif !collaborator # If collaborator cannot be found in database
      puts "\nThe collaborator cannot be found."
      prompt.select(" ", cycle: true) do |menu|
        menu.choice "Try Another Collaborator", -> { add_collaborator_page(new_project) }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    elsif collaborator
      Collaboration.create(user: collaborator, project: new_project)
      puts "\nCollaborator, #{collaborator.username} has successfully been added to your project \"#{new_project.name}\"!"
      prompt.select(" ", cycle: true) do |menu|
        menu.choice "Add Another Collaborator", -> { add_collaborator_page(new_project) }
        menu.choice "Take me To Project Menu", -> { project_menu_page(new_project) }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    end
  end

  def view_current_projects_page
    # Displays all the current projects the user has
    header
    puts "VIEW ALL CURRENT PROJECTS"
    puts 

    choices = Hash.new
    @user.projects.each { |project| choices[project.name] = project }
    
    if choices.empty?
      puts "You're not working on any project right now!"
      prompt.select("\n", cycle: true) do |menu|
        menu.choice "Create a New Project", -> { create_a_new_project_page }
        menu.choice "Collaborate on an Existing Project\n", -> { collaborate_on_an_existing_project_page }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    else
      project_selected = prompt.select("♥ Select a project:\n", choices, cycle: true)
      project_menu_page(project_selected)
    end
    ## Add option to take user back to home menu
  end

  def project_menu_page(project)
    # This displays info about a project
    header
    puts "PROJECT MENU - #{project.name}"
    puts "About: #{project.description}"
    puts

    prompt.select("♥ Select from the following options: \n", cycle: true) do |menu|
      menu.choice "View All Project Tasks", -> { view_all_project_tasks_page(project) }
      menu.choice "View/Update My Tasks", -> { view_or_update_task_page(project) }
      menu.choice "Add a New Task", -> { add_a_new_task_page(project) }
      menu.choice "View All Project Collaborators\n", -> { see_all_project_collaborators_page(project) }
      menu.choice "Go Back to View All Projects", -> { view_current_projects_page }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def see_all_project_collaborators_page(project)
    # Displays all names of collaborators of a project
    header
    puts "ALL PROJECT COLLABORATORS - #{project.name}"
    puts
    puts "Here are users currently collaborating on project \"#{project.name}\":\n"
    project.users.each_with_index { |user, idx| puts "#{idx + 1}. #{user.username}" }

    prompt.select("\n", cycle: true) do |menu|
      menu.choice "Go Back to Project Menu", -> { project_menu_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def view_all_project_tasks_page(project)
    # Display all task name, completition status, user working on that task, and due date for all tasks in the project
    header
    puts "ALL PROJECT TASKS - #{project.name}"
    puts
    all_tasks = project.tasks.order(:due_date)
    
    if all_tasks.empty?
      puts "This project doesn't have any tasks right now.\n"
    else
      all_tasks.each do |task|
        completion_status = "Not Yet!"
        completion_status = "Yep!" if task.completed
        puts "TASK → #{task.description}"
        puts "Being Done By → #{task.user.username}"
        puts "Completed? → #{completion_status}"
        puts "Due On → #{task.due_date.strftime("%m/%d/%Y")}"
        puts 
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts
      end
    end

    prompt.select("\n", cycle: true) do |menu|
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
      prompt.select("\n", cycle: true) do |menu|
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
    puts "#{project.name} - #{task.description}"
    puts

    prompt.select("♥ Select from the following:\n", cycle: true) do |menu|
      menu.choice "Mark Completed", -> { mark_complete(project, task) }
      menu.choice "Edit Task", -> { edit(project, task) }
      menu.choice "Change Due Date\n", -> { change_due_date(project, task) }
      menu.choice "Go Back to View/Update Task Page", -> { view_or_update_task_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def mark_complete(project, task)
    header
    task.change_completed
    
    puts "Task marked complete. Well done!"
    prompt.select("\n", cycle: true) do |menu|
      menu.choice "Go Back to View/Update Task Page", -> { view_or_update_task_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def edit(project, task)
    header
    new_description = prompt.ask("♥ Enter new description: ")
    task.description = new_description
    task.save
    puts "Task description updated!"

    prompt.select("\n", cycle: true) do |menu|
      menu.choice "Go Back to View/Update Task Page", -> { view_or_update_task_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def change_due_date(project, task)
    header
    puts "♥ Enter new due date for task"

    month = (prompt.ask("Enter digit(s) month with no leading 0's: ")).to_i
    day = (prompt.ask("Enter digit(s) day with no leading 0's: ")).to_i
    year = (prompt.ask("Enter 4 digits year: ")).to_i

    new_date = Time.new(year, month, day)
    task.change_due_date(new_date)

    puts "Task due date updated!"

    prompt.select("\n") do |menu|
      menu.choice "Go Back to View/Update Task Page", -> { view_or_update_task_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
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
    month = (prompt.ask("Enter digit(s) month: ")).to_i
    day = (prompt.ask("Enter digit(s) day: ")).to_i
    year = (prompt.ask("Enter 4 digits year: ")).to_i
    task_due_date = Time.new(year, month, day)

    Task.create(description: task_description, completed: false, due_date: task_due_date, project: project, user: user)

    puts "\nTask successfully created!"

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
    project_name = prompt.ask("♥ Enter project name: ")
    creator_name = prompt.ask("♥ Enter username of project creator: ")
    project = Project.find_by(name: project_name)
    creator = User.find_by(username: creator_name)

    ownership_found = Ownership.where(user: creator, project: project)

    if ownership_found.empty?
      puts "\nThis project doesn't exist!"
    elsif Collaboration.where(user: user, project: project).exists?
      puts "\nYou're already a part of this project!"
    else
      new_collaboration = Collaboration.create(user: user, project: project)
      @user = Collaboration.find_by(user: user).user
      puts "\nNice! You are now a collaborator for \"#{project.name}\"!"
    end

    prompt.select("\n") do |menu|
      menu.choice "Find Another Project to Collaborate", -> { collaborate_on_an_existing_project_page }
      menu.choice "Take Me to Project Menu", -> { project_menu_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def remove_from_project_page
    header
    puts "REMOVE MYSELF FROM A PROJECT"
    puts

    choices = Hash.new
    user.projects.each { |project| choices[project.name] = project }

    if choices.empty?
      puts "You're not a part of any project right now."
    else
      project_selected = prompt.select("♥ Select a project to stop collaborating: ", choices)
      collaboration = Collaboration.find_by(user: user, project: project_selected)
      puts "You're no longer a collaborator for \"#{project_selected.name}\"."
      deleted_collaboration = collaboration.delete   
      @user = deleted_collaboration.user
    end
    prompt.select("\n") { |menu| menu.choice "Go Back to Main Menu", -> { main_menu } }
  end

  def projects_i_created_page
    header
    puts "PROJECTS I CREATED"
    projects_owned = Project.select { |project| project.user == user }
    if projects_owned.empty?
      puts "\nYou haven't created any project yet"
      prompt.select("\n") do |menu|
        menu.choice "Create a New Project", -> { create_a_new_project_page }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    else
      choices = Hash.new
      projects_owned.each { |project| choices[project.name] = project }
      project_selected = prompt.select("♥ Select a project to go to page: ", choices, cycle: true)
      project_owner_page(project_selected)
    end
    # # Add option to go back to menu?
  end

  def project_owner_page(project)
    # displays the owner page for the project
    header
    puts "PROJECT I CREATED - #{project.name}"
    puts 
    prompt.select("♥ Select from the choices below: \n", cycle: true) do |menu|
      menu.choice "Edit Project's Name", -> { edit_project_name_page(project) }
      menu.choice "Edit Project's Description", -> { edit_project_description_page(project) }
      menu.choice "See Collaborators", -> { see_all_project_collaborators_page(project) }
      menu.choice "Add a Collaborator\n", -> { add_collaborator_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end 

  def edit_project_name_page(project)
    header
    puts "EDIT PROJECT NAME - #{project.name}"
    puts
    new_name = prompt.ask("♥ Enter a new name for the project: ")
    project.name = new_name
    project.save
    puts "\nProject's name has been changed to '#{project.name}'"

    prompt.select("\n", cycle: true) do |menu|
      menu.choice "Go Back to Project Owner Page", -> { project_owner_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def edit_project_description_page(project)
    new_description = prompt.ask("♥ Enter a new description for the project:")
    project.description = new_description
    project.save
    puts "\nProject's description has been changed to '#{project.description}'"

    prompt.select("\n") do |menu|
      menu.choice "Go Back to Project Owner Page", -> { project_owner_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end
end