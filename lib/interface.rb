#interacts and gets info/data from user

class Interface 
    attr_accessor :prompt, :user
    
    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome

        puts "

       .--.           .---.        .-.
   .---|--|   .-.     | B |  .---. |~|    .--.
.--|===|We|---|_|--.__| O |--|:::| |~|-==-|==|---.
|%%|HI!|lc|===| |~~|To| O |--|   |_|~|CLUB|BY|___|-.📚
|  |   |om|===| |==|  | K |  |:::|=| |    |::|---|=|📚
|  |   |e~|   |_|__|  |   |__|   | | |    |RK|___| |📚
|~~|===|--|===|~|~~|%%|~~~|--|:::|=|~|----|==|---|=|📚
^--^---'--^---^-^--^--^---'--^---^-^-^-==-^--^---^-'📚

"
    end

    def choose_login_or_register
        answer = self.prompt.select("Logging in or registering?", [
            "Log in",
            "Register"
        ])

        if answer == "Log in"
            #User.logging_someone_in
            puts "Logging in"
        elsif answer == "Register"
            #User.create_a_new_user
            puts "Registering"
        end
    end
end