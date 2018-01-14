require_relative '../models/address_book'

 class MenuController
   attr_reader :address_book

   def initialize
     @address_book = AddressBook.new
   end

   def main_menu
     #display main menu options ot the command line
     puts "Main Menu - #{address_book.entries.count} entries"
     puts "1 - View all entries"
     puts "2 - Create an entry"
     puts "3 - Search for an entry"
     puts "4 - Import entries from a CSV"
     puts "5 - Exit"
     print "Enter your selection: "

     #retrieve user input from the command line using gets
     #gets reads the next line from standard input
     selection = gets.to_i
     #determine proper response to user input
     case selection
      when 1
       system "clear"
       view_all_entries
       main_menu
      when 2
       system "clear"
       create_entry
       main_menu
      when 3
       system "clear"
       search_entries
       main_menu
      when 4
       system "clear"
       read_csv
       main_menu
      when 5
       puts "Good-bye!"
       #terminate program; 0 signals exit w/o error
       exit(0)
       #else to catch invalid user input and prompt the user to retry
      else
       system "clear"
       puts "Sorry, that is not a valid input"
       main_menu
     end
   end


 def view_all_entries
    #iterate through all entries in AddressBook
    address_book.entries do |entry|
      system "clear"
      puts entry.to_s
      #call entry_submenu to display a submenu for each entry
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

 def create_entry
   #clear the screen before displaying create entry prompts
   system "clear"
   puts "New AddressBloc Entry"
   #use print to prompt the user for each entry attribute
   print "Name: "
   name = gets.chomp
   print "Phone number: "
   phone = gets.chomp
   print "Email: "
   email = gets.chomp

   #add a new entry to address_book using add_entry so added in proper order
   address_book.add_entry(name, phone, email)

   system "clear"
   puts "New entry created"
  end

 def search_entries
 end

 def read_csv
end

 def entry_submenu(entry)
   #displays submenu options
     puts "n - next entry"
     puts "d - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"

     #removes any trailing whitespace from the string gets returns
     selection = gets.chomp

     case selection
     #when the user asks to see the next entry, do nothing and control
     #will be returned to view_all_entries
       when "n"
     #handle deleting and editing
       when "d"
       when "e"
     #return user to the main menu
       when "m"
         system "clear"
         main_menu
       else
         system "clear"
         puts "#{selection} is not a valid input"
         entry_submenu(entry)
     end
   end
 end
