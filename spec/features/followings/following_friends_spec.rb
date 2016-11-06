require "rails_helper"

RSpec.feature "Following Friends" do
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
  
  scenario "if signed in" do
    visit "/"
    
    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@jane.full_name)

    href = "/friendships?friend_id=#{@john.id}"
    expect(page).not_to have_link("Follow", :href => href)

    link = "a[href='/friendships?friend_id=#{@jane.id}']"
    find(link).click

    href = "/friendships?friend_id=#{@jane.id}"
    expect(page).not_to have_link("Follow", :href => href)
  end
                      
end