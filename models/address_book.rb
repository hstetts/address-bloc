#load library named entry.rb relative to address_book.rb's file path
require_relative 'entry'

   class AddressBook
     #read only entries attribute to AddressBook
     attr_reader :entries

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
   end
