require_relative '../config/environment'

interface = Interface.new()
object = interface.greeting
user_instance = interface.new_user_or_returning_user

# #new_login.new_user_or_returning_user

puts "hello world"
