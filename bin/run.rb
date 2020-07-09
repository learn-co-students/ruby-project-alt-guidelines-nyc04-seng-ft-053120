require_relative '../config/environment'

interface = Interface.new()
object = interface.greeting
user_instance = interface.new_user_or_returning_user

interface.user = object
interface.main_menu

#object = interface.main_menu

# interface.user = user_instance
# interface.main_menu

# #new_login.new_user_or_returning_user

