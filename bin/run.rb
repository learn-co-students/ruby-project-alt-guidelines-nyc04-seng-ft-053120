require_relative '../config/environment'

interface = Interface.new()
interface.welcome 
interface.choose_login_or_register

puts "Hello World"
