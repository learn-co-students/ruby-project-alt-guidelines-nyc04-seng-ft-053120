require_relative '../config/environment'

main_interface = Main.new()

# by calling the class method of welcome this stays while the rest can refresh
Main.welcome
# this below will call the remaining methods
 main_interface.login_register_prompt



