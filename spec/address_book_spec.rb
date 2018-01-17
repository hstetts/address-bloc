require_relative '../models/address_book'

#AddressBook needs an attribute to hold array of entries
#entries array will store entries so entries can be
#added, removed, and counted
RSpec.describe AddressBook do
let(:book) { AddressBook.new }


  def check_entry(entry, expected_name, expected_number, expected_email)
     expect(entry.name).to eq expected_name
     expect(entry.phone_number).to eq expected_number
     expect(entry.email).to eq expected_email
   end

  describe "attributes" do
    it "responds to entries" do
      expect(book).to respond_to(:entries)
    end

    #AddressBook should initialize entries as an empty array to use
    it "initializes entries as an array" do
      expect(book.entries).to be_an(Array)
    end

    it "initializes entries as empty" do
      expect(book.entries.size).to eq(0)
     end
   end

   describe "#add_entry" do
     it "adds only one entry to the address book" do
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

       expect(book.entries.size).to eq(1)
     end

     it "adds the correct information to entries" do
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
       new_entry = book.entries[0]

       expect(new_entry.name).to eq('Ada Lovelace')
       expect(new_entry.phone_number).to eq('010.012.1815')
       expect(new_entry.email).to eq('augusta.king@lovelace.com')
     end
   end

   describe "#remove_entry" do
     it "removes a name, phone_number, and email address entry from the address book" do
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

# Test that AddressBook's .import_from_csv() method is working as expected
   describe "#import_from_csv" do
     it "imports the correct number of entries" do
       # access the first entry in the array of entries that our address_book stores
       book.import_from_csv("entries.csv")
       book_size = book.entries.size

       expect(book_size).to eq 5
     end

     it "imports the 1st entry" do
       book.import_from_csv("entries.csv")
       # Check the first entry
       entry_one = book.entries[0]
       #helper method that consolidates code
       #allows us to pass in particular name, number, email
       check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
     end

     it "imports the 2nd entry" do
       book.import_from_csv("entries.csv")
       # Check the second entry
       entry_two = book.entries[1]
       check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
     end

     it "imports the 3rd entry" do
       book.import_from_csv("entries.csv")
       # Check the third entry
       entry_three = book.entries[2]
       check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
     end

     it "imports the 4th entry" do
       book.import_from_csv("entries.csv")
       # Check the fourth entry
       entry_four = book.entries[3]
       check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
     end

     it "imports the 5th entry" do
       book.import_from_csv("entries.csv")
       # Check the fifth entry
       entry_five = book.entries[4]
       check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end
   end

    describe "#import_from_csv2" do
       it "imports the correct number of entries" do
         # access the first entry in the array of entries that our address_book stores
         book.import_from_csv2("entries_2.csv")
         book_size = book.entries.size

         expect(book_size).to eq 3
    end

     it "imports the 1st entry" do
       book.import_from_csv2("entries_2.csv")
       # Check the first entry
       entry_one = book.entries[0]
       #helper method that consolidates code
       #allows us to pass in particular name, number, email
       check_entry(entry_one, "Kat", "555-535-4224" , "kat@blocmail.com")
     end

     it "imports the 2nd entry" do
       book.import_from_csv2("entries_2.csv")
       # Check the first entry
       entry_two = book.entries[1]
       #helper method that consolidates code
       #allows us to pass in particular name, number, email
       check_entry(entry_two, "Laura", "555-525-2222", "laura@blocmail.com")
     end

     it "imports the 3rd entry" do
       book.import_from_csv2("entries_2.csv")
       # Check the first entry
       entry_three = book.entries[2]
       #helper method that consolidates code
       #allows us to pass in particular name, number, email
       check_entry(entry_three, "Chris", "522-555-3669", "chris@blocmail.com")
     end
   end
end
