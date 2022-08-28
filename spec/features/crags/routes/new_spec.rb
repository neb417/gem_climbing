require 'rails_helper'

RSpec.describe 'Create new routes from /crags/:id/routes' do
  before :each do
    @crag1 = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800, created_at: "2022-08-20 14:28:59")
    @route1 = @crag1.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")
    @route2 = @crag1.routes.create!(route_name: 'Yellow Spur', sport_route: false, trad_route: true, pitches: 7, grade: "5.9")

    @crag2 = Crag.create!(crag_name: 'Bell Buttress', reservation_required: false, elevation: 7200, created_at: "2022-08-25 14:28:59")
    @route3 = @crag2.routes.create!(route_name: 'Verve', sport_route: true, trad_route: false, pitches: 1, grade: "5.13c")
    @route4 = @crag2.routes.create!(route_name: 'Cosmosis', sport_route: false, trad_route: true, pitches: 3, grade: "5.9")

    @crag3 = Crag.create!(crag_name: 'The Dome', reservation_required: false, elevation: 5200)
  end
  
  describe 'Adding new routes to a crag' do
    it 'has a link to add a new route to the crag' do
      visit "/crags/#{@crag3.id}/routes"

      expect(page).to have_link("Add a route to #{@crag3.crag_name}")
    end

    it 'link takes user to new form to create route' do
      visit "/crags/#{@crag3.id}/routes"
      click_link "Add a route to #{@crag3.crag_name}"

      expect(current_path).to eq("/crags/#{@crag3.id}/routes/new")
      expect(page).to have_content("Route Name")
      expect(page).to have_content("Is a Sport Route")
      expect(page).to have_content("Not a Sport Route")
      expect(page).to have_content("Is a Trad Route")
      expect(page).to have_content("Not a Trad Route")
      expect(page).to have_content("Number of Pitches")
      expect(page).to have_content("Grade")
      expect(page).to have_button("Add Route")
    end

    it 'creates a new route for the crag' do
      visit "/crags/#{@crag3.id}/routes/new"

      fill_in "Route Name", with: "The Owl"
      choose "Not a Sport Route"
      choose "Is a Trad Route"
      fill_in "Number of Pitches", with: 3
      fill_in "Grade", with: "5.7"

      click_button "Add Route"

      expect(current_path).to eq("/crags/#{@crag3.id}/routes")
      expect(page).to have_content("The Owl")
      expect(page).to have_content(3)
      expect(page).to have_content("5.7")
    end
  end 
end