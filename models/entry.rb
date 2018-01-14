class Entry

  #methods for accessing name, phone, and email
  #must be accessors since we mutate
  attr_accessor :name, :phone_number, :email

  #initializes entry
  def initialize(name, phone_number, email)
    @name = name
    @phone_number = phone_number
    @email = email
  end

  #create the string
  # \n prints a new line to the console
  def to_s
    "Name: #{name}\nPhone Number: #{phone_number}\nEmail: #{email}"
   end
end
