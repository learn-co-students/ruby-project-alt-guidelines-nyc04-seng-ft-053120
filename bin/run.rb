require_relative '../config/environment'

Paint['Ruby', :red, :blue]

interface = Interface.new()
interface.welcome 
user_instance = interface.choose_login_or_register
interface.user = user_instance

interface.main_menu

puts "Hello World" 
 

