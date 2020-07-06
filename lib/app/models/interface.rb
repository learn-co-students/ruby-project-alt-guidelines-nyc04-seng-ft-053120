require 'date'

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

  def transition_to_new_page
    # Helper function, takes in a message and a method (new_page); will display message, and transition user to new_page
    10.times do |i|
      sleep(0.2)
      print(".")
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
      puts "\nLog In Successful!\n"
      print "\nTaking you to main menu"
      transition_to_new_page
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
      transition_to_new_page
      log_in_or_register_page
    else
      new_user = User.create(username: username_input)
      @user = new_user
      puts "\nSign Up Successful!"
      print "\nTaking you to main menu"
      transition_to_new_page
      main_menu
    end
  end

  def main_menu
    # Displays options for user, each option will call a function in a proc that leads user to a new page
    header
    puts "MAIN MENU"
    puts
    puts "♥ Welcome, #{user.username}. It's a great day to get some work done!"
    puts

    prompt.select("♥ SELECT AN OPTION:\n", cycle: true) do |menu|
      menu.choice "View My Current Projects", -> { view_current_projects_page }
      menu.choice "Create a New Project", -> { create_a_new_project_page }
      menu.choice "Collaborate On An Existing Project", -> { collaborate_on_an_existing_project_page }
      menu.choice "Remove Myself From A Project", -> { remove_from_project_page }
      menu.choice "See Projects I Created\n", -> { projects_i_created_page }
      menu.choice "Log Out", -> { log_in_or_register_page }
    end
  end

  def create_a_new_project_page
    # Allowing user to create a new project, add project to database
    header
    puts "CREATE A NEW PROJECT\n"
  
    project_name_input = prompt.ask("♥ Enter new project's name: ")
    project_description_input = prompt.ask("♥ Enter a short description: ")

    new_project = user.create_new_project(project_name_input, project_description_input)
    @user = new_project.user
    puts "\nNew project: \"#{new_project.name}\", has been successfully created!\n"

    prompt.select(" ", cycle: true) do |menu|
      menu.choice "Add a Collaborator to My Project", -> { add_collaborator_page(new_project) }
      menu.choice "Take Me To Project Menu", -> { project_menu_page(new_project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def add_collaborator_page(new_project)
    # Lets user link a user to a project if the user is a valid user and if user hasn't already been linked to the project
    header
    puts "ADD A COLLABORATOR\n"

    username_input = prompt.ask("♥ Enter username of collaborator: ")
    collaborator = User.find_by(username: username_input) 

    if Collaboration.where(user: collaborator, project: new_project).exists?
      puts "\nThis collaborator is already a part of this project!"
      prompt.select(" ", cycle: true) do |menu|
        menu.choice "Try Another Collaborator", -> { add_collaborator_page(new_project) }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    elsif !collaborator 
      puts "\nThe collaborator cannot be found."
      prompt.select(" ", cycle: true) do |menu|
        menu.choice "Try Another Collaborator", -> { add_collaborator_page(new_project) }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    elsif collaborator
      Collaboration.create(user: collaborator, project: new_project)
      puts "\nCollaborator, \"#{collaborator.username}\" has successfully been added to your project \"#{new_project.name}\"!"
      prompt.select(" ", cycle: true) do |menu|
        menu.choice "Add Another Collaborator", -> { add_collaborator_page(new_project) }
        menu.choice "Take me To Project Menu", -> { project_menu_page(new_project) }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    end
  end

  def view_current_projects_page
    # Displays all the current projects the user is collaborating on
    header
    puts "VIEW ALL CURRENT PROJECTS\n" 

    choices = Hash.new
    @user.projects.each { |project| choices[project.name] = project }
    
    if choices.empty?
      puts "\nYou're not working on any project right now!"
      prompt.select("\n", cycle: true) do |menu|
        menu.choice "Create a New Project", -> { create_a_new_project_page }
        menu.choice "Collaborate on an Existing Project\n", -> { collaborate_on_an_existing_project_page }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    else
      project_selected = prompt.select("\n♥ Select a project:\n", choices, cycle: true)
      project_menu_page(project_selected)
    end
  end

  def project_menu_page(project)
    # This displays info about a project
    header
    puts "PROJECT MENU - #{project.name}"
    puts "About: #{project.description}"
    puts "Created By: #{project.user.username}"
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
    puts "\nHere are users currently collaborating on project \"#{project.name}\":\n"
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
      puts "This project doesn't have any tasks right now."
    else
      all_tasks.each do |task|
        completion_status = "Not Yet!"
        completion_status = "Yep!" if task.completed 
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts
        puts "TASK → #{task.description}"
        puts "Being Done By → #{task.user.username}"
        puts "Completed? → #{completion_status}"
        puts "Due On → #{task.due_date.strftime("%m/%d/%Y")}"
        puts
      end
    end

    prompt.select("\n", cycle: true) do |menu|
      menu.choice "Add a New Task", -> { add_a_new_task_page(project) }
      menu.choice "Go Back to Project Menu", -> { project_menu_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def view_or_update_task_page(project)
    # Lets user view or update all the tasks under their name for this project
    header
    puts "VIEW/UPDATE YOUR TASKS - #{project.name}"
    puts

    choices = Hash.new
    Task.where(user: user, project: project).each { |task| choices[task.description] = task }

    if choices.empty?
      puts "You don't have any task on this project right now."
      prompt.select("\n", cycle: true) do |menu|
        menu.choice "Add a New Task\n", -> { add_a_new_task_page(project) }
        menu.choice "Go Back to Project Menu", -> { project_menu_page(project) }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    else
      task_selected = prompt.select("♥ Select a task to edit or mark complete: ", choices)
      task_page(project, task_selected)
    end
  end

  def task_page(project, task)
    # Shows things user can do with a task
    header
    puts "TASK MENU"
    puts "#{project.name} - #{task.description}"
    puts

    prompt.select("♥ Select from the following:\n", cycle: true) do |menu|
      menu.choice "Mark Completed", -> { mark_complete(project, task) }
      menu.choice "Edit Task", -> { edit(project, task) }
      menu.choice "Change Due Date\n", -> { change_due_date(project, task) }
      menu.choice "Go Back to Project Menu", -> { project_menu_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def mark_complete(project, task)
    header
    task.change_completed
    
    puts "Task marked complete. Well done!"
    prompt.select("\n", cycle: true) do |menu|
      menu.choice "Go Back to Project Menu", -> { project_menu_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def edit(project, task)
    header
    new_description = prompt.ask("♥ Enter new description: ")
    task.description = new_description
    task.save
    puts "\nTask description updated!"

    prompt.select("\n", cycle: true) do |menu|
      menu.choice "Go Back to Project Menu", -> { project_menu_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def validate_date(str)
    # Performs validation check for the str the user entered

    # Format_ok will return true if str matches the date regex pattern
    format_ok = str.match(/\d{2}\/\d{2}\/\d{4}/) 

    # If the str cannot be parsed into a date, an error will result, but it will be rescue with a false return
    parseable = Date.strptime(str, '%m/%d/%Y') rescue false 

    # Will return true if format is good and string is parseable
    format_ok && parseable
  end
  
  def prompt_for_date
    # Prompts user for the date, output the date

    date_input = prompt.ask("♥ Enter due date in MM/DD/YYYY format: ")
    if validate_date(date_input)
      # If the date the user input is valid, return the new datetime created
      month, day, year = date_input.split("/").map { |s| s.to_i }
      Time.new(year, month, day)
    else
      # Otherwise prompt for the date again
      puts "\nDate invalid, please try again"
      puts
      prompt_for_date
    end
  end

  def change_due_date(project, task)
    header
  
    new_date = prompt_for_date
    task.change_due_date(new_date)

    puts "\nTask due date updated!"

    prompt.select("\n") do |menu|
      menu.choice "Go Back to Project Menu", -> { project_menu_page(project) }
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
    task_due_date = prompt_for_date

    Task.create(description: task_description, completed: false, due_date: task_due_date, project: project, user: user)

    puts "\nTask successfully created!"

    prompt.select("\n") do |menu|
      menu.choice "Go Back to Project Menu", -> { project_menu_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
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
      prompt.select("\n") { |menu| menu.choice "Go Back to Main Menu", -> { main_menu } }
    elsif Collaboration.where(user: user, project: project).exists?
      puts "\nYou're already a part of this project!"
      prompt.select("\n") { |menu| menu.choice "Go Back to Main Menu", -> { main_menu } }
    else
      new_collaboration = Collaboration.create(user: user, project: project)
      @user = Collaboration.find_by(user: user).user
      puts "\nNice! You are now a collaborator for \"#{project.name}\"!"
      prompt.select("\n") do |menu|
        menu.choice "Take Me to Project Menu", -> { project_menu_page(project) }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
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
      puts "\nYou're no longer a collaborator for \"#{project_selected.name}\"."
      deleted_collaboration = collaboration.delete   
      @user = deleted_collaboration.user
    end
    prompt.select("\n") { |menu| menu.choice "Go Back to Main Menu", -> { main_menu } }
  end

  def projects_i_created_page
    header
    puts "PROJECTS I CREATED\n\n"
    projects_owned = Project.select { |project| project.user == user }
    if projects_owned.empty?
      puts "You haven't created any project yet."
      prompt.select("\n") do |menu|
        menu.choice "Create a New Project", -> { create_a_new_project_page }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    else
      choices = Hash.new
      projects_owned.each { |project| choices[project.name] = project }
      project_selected = prompt.select("♥ Select a project to go to page: \n", choices, cycle: true)
      project_owner_page(project_selected)
    end
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