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
    random_quote
    puts

    prompt.select("♥ SELECT AN OPTION: ", cycle: true) do |menu|
      menu.choice "Log In", -> { log_in }
      menu.choice "Register", -> { register }
    end
  end

  def transition_to_new_page
    # Displays moving dots to indicate transition to new page
    10.times do |i|
      sleep(0.2)
      print(".")
    end
  end

  def log_in
    # Prompt for username and password inputs, find user in database, if cannot find user by username and password, output message telling user so; if username is found, take user to main menu
    username_input = prompt.ask("\n♥ Enter Username: ")
    password_input = prompt.mask("♥ Enter Password: ")

    user_found = User.find_by(username: username_input, password: password_input)

    if !user_found
      puts "\nSorry, invalid username and/or password"
      prompt.select(" ", cycle: true) do |menu|
        menu.choice "Try Again", -> {log_in} 
        menu.choice "Go Back", -> {log_in_or_register_page} 
      end
    else
      @user = user_found
      puts "\nLog In Successful!\n"
      print "\nTaking you to Main Menu"
      transition_to_new_page
      main_menu
    end
  end

  def prompt_and_validate_username
    # Helper function that prompts for and returns a valid username
    username_input = prompt.ask("\n♥ Pick a Username: ")
    user_found = User.find_by(username: username_input)
    if user_found
      puts "\nSorry, that username has been taken! Please choose another username."
      prompt_and_validate_username
    else
      return username_input
    end
  end

  def prompt_and_validate_password
    # Helper function that prompts for and returns a valid password
    password_input_1 = prompt.mask("♥ Pick a Password: ")
    password_input_2 = prompt.mask("♥ Re-enter Password: ")
    if password_input_1 != password_input_2
      puts "\n Your passwords do not match. Please try again."
      prompt_and_validate_password
    else
      return password_input_2
    end
  end

  def register
    username_input = prompt_and_validate_username
    password_input = prompt_and_validate_password

    new_user = User.create(username: username_input, password: password_input)
    @user = new_user
    puts "\nSign Up Successful!"
    print "\nTaking you to Main Menu"
    transition_to_new_page
    main_menu
  end

  def main_menu
    # Displays options for user, each option will call a function in a proc that leads user to a new page
    header
    puts "MAIN MENU"
    puts
    puts "♥ Welcome, #{user.username}. It's a great day to get some work done!"
    puts
    prompt.select("♥ SELECT AN OPTION:\n", cycle: true, per_page: 10) do |menu|
      menu.choice "View My Current Projects", -> { view_current_projects_page }
      menu.choice "Create a New Project", -> { create_a_new_project_page }
      menu.choice "Collaborate On An Existing Project", -> { collaborate_on_an_existing_project_page }
      menu.choice "Manage Projects I Created\n", -> { projects_i_created_page }
      menu.choice "Change Username", -> { change_username_page }
      menu.choice "Change Password", -> { change_password_page }
      menu.choice "Delete Account", -> { delete_account_page }
      menu.choice "Log Out", -> { log_in_or_register_page }
    end
  end

  def random_quote
    # puts a random inspirational quote
    response = RestClient.get("https://type.fit/api/quotes")
    quotes = JSON.parse(response)
    random_quote_hash = quotes.sample
    random_quote_text = random_quote_hash["text"]
    random_quote_author = random_quote_hash["author"]
    random_quote_author = "Unknown" if random_quote_author == nil
    puts "\"#{random_quote_text}\""
    puts "- #{random_quote_author}"
  end

  def change_password_page
    header
    puts "CHANGE YOUR PASSWORD\n"
    current_password = prompt.mask("♥ Enter Your Current Password: ")
    if current_password == user.password 
      puts "\nInput New Password Below"
      user.password = prompt_and_validate_password
      user.save
      puts "\nPassword Successfully Changed!"
      prompt.select(" ") { |menu| menu.choice "Go Back To Main Menu", -> { main_menu } }
    else
      puts "Password Incorrect"
      prompt.select(" ", cycle: true) do |menu|
        menu.choice "Try Again", -> { change_password_page } 
        menu.choice "Go Back To Main Menu", -> { main_menu } 
      end
    end
  end

  def change_username_page
    header
    puts "CHANGE YOUR USERNAME\n"
    puts "\nYour current username is \"#{user.username}\". What would you like your new username to be?"
    user.username = prompt_and_validate_username
    user.save
    puts "\nUsername Successfully Changed to \"#{user.username}\"!"
    prompt.select(" ") { |menu| menu.choice "Go Back To Main Menu", -> { main_menu } }
  end

  def delete_account_page
    header
    puts "DELETE MY ACCOUNT\n"
    puts 
    puts "We are sorry to see you go, #{user.username}!"
    puts
    current_password = prompt.mask("♥ Please Verify Your Password: ")
    if current_password == user.password
      prompt.select("\nAre you sure you want to delete your account? \nThis will delete ALL projects you created and ALL tasks you created. \nThis CANNOT be undone!\n", cycle: true) do |menu|
        menu.choice "Yes, Delete My Account", -> { delete_account }
        menu.choice "No, Take Me Back To Main Menu", -> { main_menu }  
      end
    else
      puts "\nDeletion unsuccessful. Password Incorrect."
      prompt.select(" ", cycle: true) do |menu|
        menu.choice "Try Again", -> {delete_account_page} 
        menu.choice "Go Back To Main Menu", -> {main_menu} 
      end
    end
  end

  def delete_account
    # Delete all collaboration instances associated with user
    all_user_collaborations = Collaboration.all.where(user: user)
    all_user_collaborations.each { |collab| collab.delete }
  
    all_user_ownerships = Ownership.all.where(user: user)

    # Delete all projects that user created through ownership
    all_projects_user_created = all_user_ownerships.map { |ownership| ownership.project }
    all_projects_user_created.each { |project| project.delete }

    # Delete all tasks user created
    all_user_tasks = Task.where(user: user)
    all_user_tasks.each { |task| task.delete }

    # Delete all ownership instances associated with user
    all_user_ownerships.each { |ownership| ownership.delete }

    # Finally delete user
    user.delete

    print "\nYour account has been deleted. Taking you back to Log In page"
    2.times { |i| transition_to_new_page }
    log_in_or_register_page
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
      project_selected = prompt.select("\n♥ Select a project:\n", choices, cycle: true, per_page: 10)
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

    prompt.select("♥ Select from the following options: \n", cycle: true, per_page: 10) do |menu|
      menu.choice "View All Project Tasks", -> { view_all_project_tasks_page(project) }
      menu.choice "View/Update My Tasks", -> { view_or_update_task_page(project) }
      menu.choice "Add a New Task", -> { add_a_new_task_page(project) }
      menu.choice "View All Project Collaborators", -> { see_all_project_collaborators_page(project) }
      menu.choice "Stop Collaborating on This Project\n", -> { remove_from_project_page(project) }
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
    all_collaborators = project.users.order(:username)
    
    if all_collaborators.empty?
      puts " This project doesn't have any collaborators right now."
    else
    all_collaborators.each_with_index{|user,idx| puts "#{idx +1}. #{user.username}"}
    end

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
        completion_status = "Not Yet! ✖"
        completion_status = "Yep! ✔" if task.completed 
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
      menu.choice "View Completed Tasks", -> { view_completed_tasks_page(project) }
      menu.choice "View Incompleted Tasks", -> { view_incomplete_tasks_page(project) }
      menu.choice "Go Back to Project Menu", -> { project_menu_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

    def view_completed_tasks_page(project)
        header
        puts "ALL COMPLETED TASKS - #{project.name}"
        puts
        completed_tasks = project.tasks.select { |task| task.completed == true }
        completed_tasks.each { |task| puts "☺#{task.description}, completed by #{task.user.username}" }
      
        prompt.select("\n", cycle: true) do |menu|
            menu.choice "View All Project Tasks", -> { view_all_project_tasks_page(project) }
            menu.choice "Go Back to Project Menu", -> { project_menu_page(project) }
            menu.choice "Go Back to Main Menu", -> { main_menu }
        end   
    end
    
    def view_incomplete_tasks_page(project)
        header
        puts "ALL INCOMPLETE TASKS - #{project.name}"
        puts
        incomplete_tasks = project.tasks.select {|task| !task.completed }
        incomplete_tasks.each { |task| puts "☺#{task.description}, being done by #{task.user.username}" }

        prompt.select("\n", cycle: true) do |menu|
            menu.choice "View All Project Tasks", -> { view_all_project_tasks_page(project) }
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
      task_selected = prompt.select("♥ Select a task to edit or mark complete: ", choices, cycle: true, per_page: 10)
      task_page(project, task_selected)
    end
  end

  def task_page(project, task)
    # Shows things user can do with a task
    header
    puts "TASK MENU"
    puts "#{project.name} - #{task.description}"
    puts

    prompt.select("♥ Select from the following:\n", cycle: true, per_page: 10) do |menu|
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
    @user = task.user
    
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
    @user = task.user
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

    task_created = Task.create(description: task_description, completed: false, due_date: task_due_date, project: project, user: user)
    @user = task_created.user

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
    # If there are no existing projects, puts statement and direct user to create one or go to main menu

    if Project.all.empty? 
      puts "There are no existing project right now."
      prompt.select("\n") do |menu|
        menu.choice "Create a New Project", -> { create_a_new_project_page }
        menu.choice "Go Back to Main Menu", -> { main_menu }
      end
    else
      puts "Existing Projects:\n"
      # Show user a list of projects and creators in database
      existing_projects_and_creators
      puts 
      project_name = prompt.ask("♥ Enter the name of project you want to collaborate on: ")
      creator_name = prompt.ask("♥ Enter the username of project creator: ")
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
  end

  def existing_projects_and_creators
    # Helper function, outputs a list of projects and creators
    Project.all.each { |project| puts "- Name: #{project.name}\n- Creator: #{project.user.username}\n\n"}
  end

  def remove_from_project_page(project)
    header
    puts "REMOVE MYSELF AS COLLABORATOR FROM A PROJECT"
    prompt.select("\nAre you sure you want to remove yourself as collaborator from \"#{project.name}\"? \nThis will delete ALL tasks you created in this project.\n", cycle: true) do |menu|
      menu.choice "Yes, Remove Myself As Collaborator", -> { remove_from_project(project) }
      menu.choice "No, Take Me Back to Project Menu", -> { project_menu_page(project) }
    end
  end

  def remove_from_project(project)
    header
    puts "REMOVE MYSELF AS COLLABORATOR FROM A PROJECT"
    puts
    # if the user is the creator of the project, they cannot remove themselves as collaborator, direct them to manage project page
    if user == project.user
      puts "You cannot remove yourself as collaborator because you are the creator of this project!"

      prompt.select("\n", cycle: true) do |menu|
      menu.choice "Go Back to Project Menu", -> { project_menu_page(project) }
      menu.choice "Go Back To Main Menu", -> { main_menu }
      end
    else
      collaboration = Collaboration.find_by(user: user, project: project)
      # delete tasks on this project that the user has created
      Task.where(user: user).each { |task| task.delete }
      # delete the collaboration between user and project
      deleted_collaboration = collaboration.delete   
      @user = deleted_collaboration.user

      puts "\nRemoval success. You're no longer a collaborator for \"#{project.name}\"."
      prompt.select("\n") { |menu| menu.choice "Go Back to Main Menu", -> { main_menu } }
    end
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
    prompt.select("♥ Select from the choices below: \n", cycle: true, per_page: 10) do |menu|
      menu.choice "Edit Project's Name", -> { edit_project_name_page(project) }
      menu.choice "Edit Project's Description", -> { edit_project_description_page(project) }
      menu.choice "See Collaborators", -> { see_all_project_collaborators_page(project) }
      menu.choice "Add a Collaborator", -> { add_collaborator_page(project) }
      menu.choice "Delete This Project\n", -> { delete_project_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end 

  def delete_project_page(project)
    header
    puts "DELETE PROJECT: #{project.name}"
    puts 
    prompt.select("♥ Are you SURE you want to delete \"#{project.name}\"?\nThis will delete ALL project tasks and end ALL collaborations on the project.\n", cycle: true) do |menu|
      menu.choice "Yes, Delete This Project", -> { delete_project(project) }
      menu.choice "No, Take me Back to Main Menu", -> { main_menu }
    end
  end

  def delete_project(project)
    # Helper function
    puts
    puts "\"#{project.name}\" has been deleted."
    # Deletes all project's tasks
    project.tasks.each { |task| task.delete }
    # deletes all collaborations
    project.collaborations { |collab| collab.delete }
    # deletes ownership
    project.ownership.delete
    # deletes the project
    project.delete
    @user = project.user
    prompt.select("\n", cycle: true) { |menu| menu.choice "Go Back to Main Menu", -> { main_menu }}
  end

  def edit_project_name_page(project)
    header
    puts "EDIT PROJECT NAME - #{project.name}"
    puts
    new_name = prompt.ask("\n♥ Enter a new name for the project: ")
    project.name = new_name
    project.save
    puts "\nProject's name has been changed to \"#{project.name}\""

    prompt.select("\n", cycle: true) do |menu|
      menu.choice "Go Back to Project Owner Page", -> { project_owner_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end

  def edit_project_description_page(project)
    new_description = prompt.ask("\n♥ Enter a new description for the project:")
    project.description = new_description
    project.save
    puts "\nProject's description has been changed to \"#{project.description}\""

    prompt.select("\n") do |menu|
      menu.choice "Go Back to Project Owner Page", -> { project_owner_page(project) }
      menu.choice "Go Back to Main Menu", -> { main_menu }
    end
  end
end