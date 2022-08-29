require 'rails_helper'

RSpec.describe 'crags show page' do
  before :each do
    @crag1 = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800)
    @route1 = @crag1.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")
    @route2 = @crag1.routes.create!(route_name: 'Yellow Spur', sport_route: false, trad_route: true, pitches: 7, grade: "5.9")

    @crag2 = Crag.create!(crag_name: 'Bell Buttress', reservation_required: false, elevation: 7200)
    @route3 = @crag2.routes.create!(route_name: 'Verve', sport_route: true, trad_route: false, pitches: 1, grade: "5.13c")
    @route4 = @crag2.routes.create!(route_name: 'Cosmosis', sport_route: false, trad_route: true, pitches: 3, grade: "5.9")
  end

  describe 'User story 2' do
    it 'displays the crag name' do

      visit "/crags/#{@crag1.id}"

      expect(page).to have_content(@crag1.crag_name)
      expect(page).to_not have_content(@crag2.crag_name)
    end

    it 'displays the crag information' do

      visit "/crags/#{@crag2.id}"

      expect(page).to have_content(@crag2.crag_name)
      expect(page).to have_content(@crag2.reservation_required)
      expect(page).to have_content(@crag2.elevation)
      expect(page).to_not have_content(@crag1.crag_name)
      expect(page).to_not have_content(@crag1.reservation_required)
      expect(page).to_not have_content(@crag1.elevation)
    end
  end

  describe "User Story 7" do
    it 'show the count of routes for a crag' do
      visit "/crags/#{@crag2.id}"
      expect(page).to have_content("#{@crag2.crag_name} has #{@crag2.count_routes} routes.")
    end
  end

  describe 'User Story 10 link on page for /routes' do
    it 'has a link for /routes' do
      visit "/crags/#{@crag1.id}/routes"

      expect(page).to have_link("Routes")
    end

    it "when 'routes' link click, take user to /routes" do
      visit "/crags/#{@crag2.id}/routes"

      click_link "Routes"

      expect(current_path).to eq('/routes')
    end
  end

  describe 'User Story 19 deleting crags from show page' do
    it 'has a button to delete' do
      visit "/crags/#{@crag1.id}"

      expect(page).to have_button("Delete #{@crag1.crag_name} and Routes")
    end

    it 'removes the crag and routes from site' do
      visit "/crags"
      expect(page).to have_content(@crag1.crag_name)
      expect(page).to have_content(@crag1.reservation_required)
      expect(page).to have_content(@crag1.elevation)
      
      visit "/routes"
      
      expect(page).to have_content(@route1.route_name)
      
      visit "/crags/#{@crag1.id}"
      
      click_button "Delete #{@crag1.crag_name} and Routes"
      
      expect(current_path).to eq("/crags")
      expect(page).to_not have_content(@crag1.crag_name)
      expect(page).to_not have_content(@crag1.reservation_required)
      expect(page).to_not have_content(@crag1.elevation)
      expect(page).to have_content(@crag2.crag_name)
      expect(page).to have_content(@crag2.reservation_required)
      expect(page).to have_content(@crag2.elevation)

      visit "/routes"
      expect(page).to_not have_content(@route1.route_name)
      expect(page).to have_content(@route3.route_name)
    end
  end
end