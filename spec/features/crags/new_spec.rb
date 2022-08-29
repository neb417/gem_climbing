require 'rails_helper'

RSpec.describe 'creates new crag' do
  describe 'link on page for /crags' do
    it 'has a link for to create new crag' do
      visit '/crags'

      expect(page).to have_link('Create New Crag')
    end

    it "when 'Create New Crag' link click, take user to crags/new" do
      visit '/crags'
      click_link 'Create New Crag'

      expect(current_path).to eq('/crags/new')
    end

    it 'Form with crag attributes is generated' do
      visit '/crags/new'

      expect(page).to have_content('Crag Name')
      expect(page).to have_content('Elevation')
      expect(page).to_not have_content('Grade')
    end

    it 'has a Create Crag submit button' do
      visit '/crags/new'

      expect(page).to have_button('Create Crag')
    end

    it 'redirects to /crags' do
      visit '/crags/new'

      click_button 'Create Crag'

      expect(current_path).to eq('/crags')
    end

    it 'can create new crag' do
      visit '/crags/new'

      fill_in('Crag Name', with: 'The Dome')
      choose 'Reservation Required'
      fill_in('Elevation', with: 5700)

      click_button 'Create Crag'
      expect(current_path).to eq('/crags')
      expect(page).to have_content('The Dome')
    end
  end

  describe 'Error handling for not having inputs/incorrect inputs' do
    it 'has page that displays message of incorrect info' do
      visit '/crags/new'

      click_button "Create Crag"

      expect(current_path).to eq("/crags")
      expect(page).to have_content("Crag not created: Required information missing")
    end

    it 'has page that displays message of incorrect info' do
      visit '/crags/new'

      fill_in("Crag Name", with: "The Dome")

      click_button "Create Crag"

      expect(current_path).to eq("/crags")
      expect(page).to have_content("Crag not created: Required information missing")
    end

    it 'has page that displays message of incorrect info' do
      visit '/crags/new'

      fill_in("Crag Name", with: "The Dome")
      choose "No Reservation Required"

      click_button "Create Crag"

      expect(current_path).to eq("/crags")
      expect(page).to have_content("Crag Name")
    end
  end
end