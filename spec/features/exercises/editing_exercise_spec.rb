require 'rails_helper'

RSpec.feature "Editing Exercise" do
  before do
    @owner = User.create!(first_name: "John", last_name: "Doe", email: "owner@example.com", password: "password", first_name: "John", last_name: "Doe")
    
    @owner_exercise = @owner.exercises.create!(length_in_pp: 48,
                                                workout: "My novel reading activity",
                                                workout_date: Date.today)
                                                
    login_as(@owner)
  end
  
  scenario "with valid data succeeds" do
    visit '/'
    
    click_link "My Lounge"
    
    path = "/users/#{@owner.id}/exercises/#{@owner_exercise.id}/edit"
    link = "a[href=\'#{path}\']"
    find(link).click
    
    fill_in "Length", with: 45
    click_button "Update Exercise"
    
    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(45)
    expect(page).not_to have_content(48)
  end
  
end