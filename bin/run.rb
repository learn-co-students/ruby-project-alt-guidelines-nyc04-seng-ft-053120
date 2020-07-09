

require_relative '../config/environment'
 
interface = Interface.new()
interface.welcome
instance = interface.get_instance
until instance
   instance = interface.get_instance
end
interface.customer = instance
interface.show_menu


<<<<<<< HEAD
=======
interface = Interface.new()
interface.welcome
instance=interface.get_instance
until instance
    instance=interface.get_instance
end
interface.customer=instance
interface.show_menu
>>>>>>> efc8b8a504419dbd219b99baabae7c129d73a4cc
