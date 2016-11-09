require "rails_helper"

RSpec.feature "Listing Exercises" do
  before do
   @john = User.create(email: "john@example.com", 
                      password: "password", 
                      first_name: "John", 
                      last_name: "Doe")
   
   @jane = User.create(email: "janeh@example.com", 
                      password: "password", 
                      first_name: "Jane", 
                      last_name: "Doe")
   
    @e1 = @john.exercises.create(length_in_pp: 20,
                                  workout: "My novel reading activity",
                                  workout_date: Date.today)
                                  
    @e2 = @jane.exercises.create(length_in_pp: 55,
                                  workout: "Chapter one",
                                  workout_date: Date.today)
                                  
    login_as(@john)                                  
  
    @following = Friendship.create(user: @john, friend: @jane)
  end
  
  scenario "shows user's workout for last 7 days" do
    visit '/'
    
    click_link "My Lounge"
    click_link @jane.full_name
    
    expect(page).to have_content(@jane.full_name + "'s Exercises")
    expect(page).to have_content(@e2.workout)
    expect(page).to have_css("div#chart")
  end
  
end