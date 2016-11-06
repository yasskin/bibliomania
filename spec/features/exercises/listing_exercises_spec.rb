require "rails_helper"

RSpec.feature "Listing Exercises" do
  before do
   @john = User.create(email: "john@example.com", password: "password", first_name: "John", last_name: "Doe")
   
   @sarah = User.create(email: "sarah@example.com", password: "password", first_name: "Sarah", last_name: "Anderson")
   
    login_as(@john)
    
    @e1 = @john.exercises.create(length_in_pp: 20,
                                  workout: "My novel reading activity",
                                  workout_date: Date.today)
                                  
    @e2 = @john.exercises.create(length_in_pp: 55,
                                  workout: "Chapter one",
                                  workout_date: 2.days.ago)
                                  
    # @following = Friendship.create(user: @john, friend: @sarah)
                                  
    @e3 = @john.exercises.create(length_in_pp: 35,
                                  workout: "On sofa",
                                  workout_date: 8.days.ago)
  end
  
  scenario "shows user's workout for last 7 days" do
    visit '/'
    
    click_link "My Lounge"
    
    expect(page).to have_content(@e1.length_in_pp)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)
    
    expect(page).to have_content(@e2.length_in_pp)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)
    
    expect(page).not_to have_content(@e3.length_in_pp)
    expect(page).not_to have_content(@e3.workout)
    expect(page).not_to have_content(@e3.workout_date)

  end
  
  scenario "shows no exercises if none created" do
    @john.exercises.delete_all
    
    visit '/'
    
    click_link "My Lounge"
    
    expect(page).to have_content("No Workouts Yet")
  end
  
  # scenario "shows a list of user's friends" do
  #   visit '/'
    
  #   click_link "My Lounge"
  #   expect(page).to have_content("My Friends")
  #   expect(page).to have_content(@sarah.full_name)
  #   expect(page).to have_link("Unfollow")
  # end
  
end