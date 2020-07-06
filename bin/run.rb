require_relative '../config/environment'

interface = Interface.new()
interface.log_in_page

user_instance = interface.log_in_page

unless user_instance
  user_instance = interface.log_in_page
end

interface.user = user_instance

interface.main_menu