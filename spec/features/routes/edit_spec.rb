require 'rails_helper'

RSpec.describe 'crag edit' do
  before :each do
    @crag1 = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800, created_at: "2022-08-20 14:28:59")
    @route1 = @crag1.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")
    @route2 = @crag1.routes.create!(route_name: 'Yellow Spur', sport_route: false, trad_route: true, pitches: 7, grade: "5.9")

    @crag2 = Crag.create!(crag_name: 'Bell Buttress', reservation_required: false, elevation: 7200, created_at: "2022-08-25 14:28:59")
    @route3 = @crag2.routes.create!(route_name: 'Verve', sport_route: true, trad_route: false, pitches: 1, grade: "5.13c")
    @route4 = @crag2.routes.create!(route_name: 'Cosmosis', sport_route: false, trad_route: true, pitches: 3, grade: "5.9")
    
    @crag3 = Crag.create!(crag_name: 'The Dome', reservation_required: false, elevation: 5200)
    @route5 = @crag3.routes.create!(route_name: 'Umph Crack', sport_route: true, trad_route: false, pitches: 2, grade: "5.11")
  end

  describe 'User Story 14 Editing routes' do
    it 'has a link on route show page to edit route that redirects' do
      visit "/routes/#{@route5.id}"

      expect(page).to have_link("Edit #{@route5.route_name}")

      click_link "Edit #{@route5.route_name}"

      expect(current_path).to eq("/routes/#{@route5.id}/edit")
    end

    it 'has a form to edit route' do
      visit "/routes/#{@route5.id}"
      click_link "Edit #{@route5.route_name}"
      expect(current_path).to eq("/routes/#{@route5.id}/edit")
      expect(page).to have_content("Route Name")
      expect(page).to have_content("Is a Sport Route")
      expect(page).to have_content("Is a Trad Route")
      expect(page).to have_content("Number of Pitches")
      expect(page).to have_content("Grade")
      expect(page).to have_button("Update Route")
    end

    it 'is editted on the show page' do
      visit "/routes/#{@route5.id}"
      click_link "Edit #{@route5.route_name}"

      fill_in "Route Name", with: "The Owl"
      choose "Not a Sport Route"
      choose "Is a Trad Route"
      fill_in "Number of Pitches", with: 3
      fill_in "Grade", with: "5.7"

      click_button "Update Route"
      expect(current_path).to eq("/routes/#{@route5.id}")
      expect(page).to have_content("The Owl")
      expect(page).to have_content(3)
      expect(page).to have_content("5.7")
    end
  end
end