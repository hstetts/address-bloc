require_relative '../models/address_book'

#AddressBook needs an attribute to hold array of entries
#entries array will store entries so entries can be
#added, removed, and counted
RSpec.describe AddressBook do
  describe "attributes" do
    it "responds to entries" do
      book = AddressBook.new
      expect(book).to respond_to(:entries)
    end

    #AddressBook should initialize entries as an empty array to use
    it "initializes entries as an array" do
      book = AddressBook.new
      expect(book.entries).to be_an(Array)
    end

    it "initializes entries as empty" do
      book = AddressBook.new
      expect(book.entries.size).to eq(0)
     end
   end

   describe "#add_entry" do
     it "adds only one entry to the address book" do
       book = AddressBook.new
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

       expect(book.entries.size).to eq(1)
     end

     it "adds the correct information to entries" do
       book = AddressBook.new
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
       new_entry = book.entries[0]

       expect(new_entry.name).to eq('Ada Lovelace')
       expect(new_entry.phone_number).to eq('010.012.1815')
       expect(new_entry.email).to eq('augusta.king@lovelace.com')
     end
   end

   describe "#remove_entry" do
     it "removes a name, phone_number, and email address entry from the address book" do
       #create new address book
       book = AddressBook.new
       #add new entry first to pass remove_entry test
       book.add_entry('Sally Smith', '010.032.5281', 'sally.smith@smith.com')

       #add second entry so we have one to delete
       name = "Ada Lovelace"
       phone_number = "010.012.1815"
       email_address = "augusta.king@lovelace.com"
       #adds entry to book passing in three variables
       book.add_entry(name, phone_number, email_address)

       #expect the book to have 2 entries
       expect(book.entries.size).to eq(2)
       #remove an entry passing in 3 variables
       book.remove_entry(name, phone_number, email_address)
       #expect now that the book entry size is equal to 1
       expect(book.entries.size).to eq(1)
       #final expect to validate correct entry is removed
       expect(book.entries.first.name).to eq("Sally Smith")
     end
   end
 end
