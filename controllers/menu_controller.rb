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
		puts "5 - Delete All Entries"
		puts "6 - Exit"
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
			system "clear"
			detonate_all
			main_menu
		when 6
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
		@address_book.entries.each do |entry|
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
		@address_book.add_entry(name, phone, email)

		system "clear"
		puts "New entry created"
	end

	def search_entries
    #get name user searches for
    print "Search by name: "
    name = gets.chomp
    #call search on address_book which will return match or nil
    #will never return empty string since import_from_csv fails if entry has no name
    match = address_book.binary_search(name)
    system "clear"
    #check if search returned match
    #puts match.to_s evaluates to false if returns nil (nil = false)
    #if search finds match, call helper method search_submenu
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
	end

  #search_submenu displays list of operations to perform on Entry
  def search_submenu(entry)
    #print out submenu for entry
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    #save user input to selection
    selection = gets.chomp

    #case to take specific action based on user input
    case selection
      #call delete_entry and call main_menu after it returns
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      #call edit_entry
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      #returns to main_menu
      when "m"
        system "clear"
        main_menu
      #if no match, clear the screen and ask for input again
      #by calling search_submenu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end


	def read_csv
		#prompt user to enter a name of a CSV file to Import
		#Get the filename from STDIN and call chomp to remove newlines
		print "Enter CSV file to import:"
		file_name = gets.chomp

		#check if filename is empty
		#if yes, return the user back to main_menu
		if file_name.empty?
			system "clear"
			puts "No CSV file to read"
			main_menu
		end
		#import file with import_from_csv on address_book
		#clear the screen and print # of entries read from file
		#wrap in begin/rescue to protect program from crashing if exception thrown
		begin
			entry_count = address_book.import_from_csv(file_name).count
			system "clear"
			puts "#{entry_count} new entries added from #{file_name}"
		rescue
			puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
			read_csv
		end
	end

	def detonate_all
		puts "Are you sure you want to delete all entries?"
		puts "Enter: \"y\" for Yes and \"n\" for No"
		selection = gets.chomp

			if selection == "y"
				#remove all entries from address_book
		    @address_book.detonate_all
		    puts "All entries have been deleted."
			else
				if selection == "n"
				main_menu
			end
		end
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
      #call delete_entry when user pressed d in submenu
      #after entry is deleted, controll will return to view_all_entries
      #and next entry will be displayed
      delete_entry(entry)
		when "e"
      #call edit_entry for e and display a submenu
      #with entry_submenu for the entry under edit
			edit_entry(entry)
      entry_submenu(entry)
		when "m"
			system "clear"
      #return user to the main menu
			main_menu
		else
			system "clear"
			puts "#{selection} is not a valid input"
			entry_submenu(entry)
		end
	end

  def delete_entry(entry)
    #remove entry from address_book and pring out message
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)
    #perform a series of print statements
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp
    #!attribute.empty? to set attribes on entry only if valid attribute
    #was read from the user input
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"
    #print out updated entry attributes
    puts "Updated entry:"
    puts entry
  end

end
