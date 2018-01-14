#loads entry model for testing
require_relative '../models/entry'

#instating file is a spec file and it tests entry.rb
 RSpec.describe Entry do
   #test structure to communicate the specs test the Entry attributes
   describe "attributes" do

     #values for the entries
     #define an entry method (let) to apply to all tests instead of
     #instead of creating a local variable within each test
     let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }

     #each individual test separated by it method
     it "responds to name" do

       #declares the expectations for the test.
       #if met, test passes. if not, fails.
       #checks whether entry.name is valid code
       expect(entry).to respond_to(:name)
     end

     #report test is to read the attributes value
     it "reports its name" do
       expect(entry.name).to eq('Ada Lovelace')
     end

     it "responds to phone number" do
       expect(entry).to respond_to(:phone_number)
     end

     it "reports its phone_number" do
       expect(entry.phone_number).to eq('010.012.1815')
     end

     it "responds to email" do
       expect(entry).to respond_to(:email)
     end

     it "reports its email" do
       expect(entry.email).to eq('augusta.king@lovelace.com')
     end
   end

   #use a new describe block to separate the to_s test from initializer tests
   # the "#" indicates it is an instance method
   describe "#to_s" do
     it "prints an entry as a string" do
       entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
       expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"

       # eq to check that to_s returns a string equal to expected_string
       expect(entry.to_s).to eq(expected_string)
     end
   end
 end
