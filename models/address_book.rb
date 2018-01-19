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

	def iterative_search(name)

		@entries.each do |entry|
			if name == entry.name
				return entry
			end
		end

		return nil
	end

	def binary_search(name)
		 #save the index of the leftmost item in the array in lower
		 #save rightmost item in array in upper
		 lower = 0
	   upper = entries.length - 1

	   #loop while our lower index is less than or equal to upper
	   while lower <= upper
	     #find the middle index by taking sum of lower and upper and divide by 2
			 #ruby truncates decimal numbers
			 #retrieve name of entry at middle index and store as mid_name
	     mid = (lower + upper) / 2
	     mid_name = entries[mid].name

	     #compare searched name to name of middle index
			 #if name is equal to mid_name, found name, so return entry at index mid
	     if name == mid_name
	       return entries[mid]
			 #if name is alphabetically before mid_name, set upper to mid-1
			 #b/c name must be in lower half of array
	     elsif name < mid_name
	       upper = mid - 1
			 #if name is alphabetically after mid_name, set lower to mid + 1
			 #b/c name must be in upper half of array
	     elsif name > mid_name
	       lower = mid + 1
	     end
	   end

	   #if we divide and conquer above with no match, return nil
	   return nil
	 end
end
