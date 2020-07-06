class User < ActiveRecord::Base
    has_many :comments
    has_many :minions
    has_many :like
end

def self.log_someone_in
    prompt = TTY::prompt.new
    username_of_the_user = prompt.ask("what is your username?")
    found_user = User.find_by(user_name: username_of_the_user)
end

def self.create_new_user
    prompt = TTY::Prompt.new
    username_of_the_user = prompt.ask("what would you like your username to be?")
    User.create(user_name: username_of_the_user)
end
