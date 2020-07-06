class User < ActiveRecord::Base
    has_many :comments
    has_many :minions
    has_many :like
    
    def self.check_user
        random_usernames = ["PowerpuffGirl279", "WedgeBiggs007", "YogaPosePretzel", "NoForksGiven","KanyeForPresident","CoffeeDaddy", "HobbitFeet429", "Mordor69", "Raffyisbae", "CharmanderCHARBOK", "TeenageMutantNinjaSquirtles", "Raffyisagoodboy", "RaffyAteMyLab", "ChuckNorrisLover"].sample
        prompt = TTY::Prompt.new
        username = prompt.ask("what would you like your username to be?")
        if User.find_by(user_name: username)
            puts "~~~~~~Sorry that user name was taken, how about you try: #{random_usernames}~~~~~"
            self.check_user 
            
        elsif
            username
        end
    end
    
    
    
def self.log_someone_in
    prompt = TTY::Prompt.new
    username = prompt.ask("what is your username?")
    pass = self.password_prompt
    if found_user = User.find_by(user_name: username) && User.find_by(password: pass)
        puts "Welcome back #{username} today is #{Time.now} "
        found_user.display_profile
    elsif
        puts "your username or password are incorrect."
    end
    end

def self.create_a_new_user
    prompt = TTY::Prompt.new
    username = self.check_user
    
    pass = self.password_prompt
    cohort = prompt.select("What Cohort do you belong to", [
        "Pryñatas",
        "404's", 
        "The Git Up",
        "NOLB",
        "The Go Gitters",
        "French Pry Cult"
    ])
    
    new_user = User.create(user_name: username, password: pass, cohort: cohort)
    puts "Welcome #{username},                                   \nyour password is #{pass} don't lose it,               \nbecause we have no way of retrieving it for you... \noh and ummm you now belong to us. #{cohort}         ".white.on_red.blink
    new_user.display_profile
end

def self.password_prompt
    prompt = TTY::Prompt.new
    password = prompt.mask("what is your password?") 
    if password.length < 4
        puts "Your password is not long enough, to party (minimum 4 character)"
        self.password_prompt
    end
    password
end



def display_profile

    prompt = TTY::Prompt.new  
    renderer = TTY::Table::Renderer::ASCII.new(user_table)
     
    
end

def user_table
    array = [self]
    binding.pry
end



end