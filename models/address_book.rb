#load library named entry.rb relative to address_book.rb's file path
require_relative 'entry.rb'
require "csv"

class AddressBook
	#read only entries attribute to AddressBook
	attr_accessor :entries

	#initializes empty entries array
	def initialize
		@entries = []
	end

	#method to update entries array
	def add_entry(name, phone_number, email)
		#create a variable to store the insertion index
		index = 0
		@entries.each do |entry|
			#compare name with name of the current entry
			#if name lexicographically proceeeds entry.name, we found index to insert at
			if name < entry.name
				break
			end
			#otherwise we increment index and continue comparing with other entries
			index+= 1
		end
		#insert a new entry into entries using the calculated index
		@entries.insert(index, Entry.new(name, phone_number, email))
	end

	#define method to remove entries
	def remove_entry(name, phone_number, email)
		#instates an empty variable to redefine later
		delete_entry = 0

		#iterate over entries
		@entries.each do |entry|
			#if name, phone and email match, delete_entry variable becomes that entry
			if name == entry.name && phone_number == entry.phone_number && email == entry.email
				delete_entry = entry
			end
		end

		#delete_entry is deleted from the entries array
		@entries.delete(delete_entry)
	end

  #define import_from_csv
  #method starts by reading file.read in csv format
  def import_from_csv(file_name)
    # Implementation goes here
     csv_text = File.read(file_name)
     csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

     #iterate over CSV::Table object's rows
     #create hash for each row
     #convert each row_hash to an Entry using the add_entry method
     csv.each do |row|
       row_hash = row.to_hash
       add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
     end
  end
end
