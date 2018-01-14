require_relative 'entry'

   class AddressBook
     attr_reader :entries

     def initialize
       @entries = []
     end

   def add_entry(name, phone_number, email)
     # #9
     index = 0
     entries.each do |entry|
     # #10
       if name < entry.name
         break
       end
       index+= 1
     end
     # #11
     entries.insert(index, Entry.new(name, phone_number, email))
   end
 end
