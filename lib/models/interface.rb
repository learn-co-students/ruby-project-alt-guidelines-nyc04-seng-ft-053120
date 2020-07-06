class Interface
    attr_accessor :prompt, :user

    def initialize
        @prompt = TTY::Prompt.new

    end

    def greeting 
        puts "Welcome"
     end

    #  def new_user_or_returning_user
    #     answer = prompt.select("Are you a new user or returning user?", [
    #         "New User", 
    #         "Returning User"
    #     ])
    #     if answer == "New User"
    #         User.create_new_user
    #     elsif answer == "Returning User"
    #         User.returning_user
    #     end

    #  end
end