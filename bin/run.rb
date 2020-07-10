

require_relative '../config/environment'
 
interface = Interface.new()
interface.welcome
instance = interface.get_instance
until instance
   instance = interface.get_instance
end
interface.customer = instance
interface.show_menu


