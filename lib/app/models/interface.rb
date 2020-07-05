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
    puts "Welcome to Twogether, A CLI Project Collaboration App"
    puts 
    prompt.select("SELECT AN OPTION: ") do |menu|
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
    puts "WELCOME, #{user.username}!"
    puts

    prompt.select("Choose from the following options:\n") do |menu|
      menu.choice "View My Current Projects", -> {self.view_current_projects_page}
      menu.choice "Create a New Project", -> {self.create_a_new_project_page}
      menu.choice "Collaborate On An Existing Project", -> {self.collaborate_on_an_existing_project_page}
      menu.choice "Remove Myself From A Project", -> {self.remove_from_project_page}
      menu.choice "See Projects I Created\n", -> {self.projects_i_created_page}
      menu.choice "Log Out", -> {self.log_in_page}
    end
  end

  # def create_a_new_project_page
  #   header
  #   puts "CREATE A NEW PROJECT"
  #   puts

  #   project_name_input = prompt.ask("Enter new project's name: ")
  #   project_description_input = prompt.ask("Enter a short description: ")

  #   new_project = user.create_new_project(project_name_input, project_description_input)
  #   # incomplete!!!

  # end
end