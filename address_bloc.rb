require_relative 'controllers/menu_controller'

#create a new MenuController when AddressBloc starts
menu = MenuController.new

#clear command line
system "clear"
puts "Welcome to AddressBloc!"

#call main_menu to display the menu
menu.main_menu
