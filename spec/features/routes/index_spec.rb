require 'rails_helper'

RSpec.describe 'crags index page' do
  before :each do
    @crag1 = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800, created_at: "2022-08-20 14:28:59")
    @route1 = @crag1.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")
    @route2 = @crag1.routes.create!(route_name: 'Yellow Spur', sport_route: false, trad_route: true, pitches: 7, grade: "5.9")

    @crag2 = Crag.create!(crag_name: 'Bell Buttress', reservation_required: false, elevation: 7200, created_at: "2022-08-25 14:28:59")
    @route3 = @crag2.routes.create!(route_name: 'Verve', sport_route: true, trad_route: false, pitches: 1, grade: "5.13c")
    @route4 = @crag2.routes.create!(route_name: 'Cosmosis', sport_route: false, trad_route: true, pitches: 3, grade: "5.9")

    @crag3 = Crag.create!(crag_name: 'The Dome', reservation_required: false, elevation: 5200)
  end

  describe 'Test for index page' do
    it 'displays routes' do
      visit "/routes"

      expect(page).to have_content("Desdichado")
      expect(page).to have_content("5.13d")
      expect(page).to have_content("Verve")
      expect(page).to have_content("5.13c")
      expect(page).to_not have_content("Yellow Spur")
      expect(page).to_not have_content("Cosmosis")
    end
  end

  describe 'Editing routes from route index page' do
    it 'has a link on route show page to edit route that redirects' do
      visit "/routes"

      expect(page).to have_link("Edit #{@route1.route_name}")
      expect(page).to have_link("Edit #{@route3.route_name}")

      click_link "Edit #{@route3.route_name}"

      expect(current_path).to eq("/routes/#{@route3.id}/edit")
    end
  end

  describe 'deleting routes from show page' do
    it 'has a button to delete' do
      visit "/routes/"

      expect(page).to have_button("Delete #{@route1.route_name}")
      expect(page).to have_button("Delete #{@route3.route_name}")
    end

    it 'removes the crag and routes from site' do
      visit "/routes"

      expect(page).to have_content(@route1.route_name)
      expect(page).to have_content(@route3.route_name)

      click_button "Delete #{@route1.route_name}"

      expect(current_path).to eq("/routes")
      expect(page).to_not have_content(@route1.route_name)
      expect(page).to_not have_content(@route1.grade)
      expect(page).to have_content(@route3.route_name)
      expect(page).to have_content(@route3.grade)
    end
  end
end