require "rails_helper"

RSpec.feature "Listing Members" do
  before do 
    @john = User.create(first_name: "John", 
                        last_name: "Doe", 
                        email: "john@example.com",
                        password: "Password")
    @jane = User.create(first_name: "Jane", 
                        last_name: "Doe", 
                        email: "jane@example.com",
                        password: "Password")  
  end
  
  scenario "shows a list of registered members" do
    visit "/"
    
    expect(page).to have_content("List of Members")
    expect(page).to have_contnet(@john.full_name)
    expect(page).to have_contnet(@jane.full_name)
  end
                      
end