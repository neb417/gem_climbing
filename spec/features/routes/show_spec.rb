require 'rails_helper'

RSpec.describe 'routes show page' do
  before :each do
    @crag1 = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800)
    @route1 = @crag1.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")
    @route2 = @crag1.routes.create!(route_name: 'Yellow Spur', sport_route: false, trad_route: true, pitches: 7, grade: "5.9")

    @crag2 = Crag.create!(crag_name: 'Bell Buttress', reservation_required: false, elevation: 7200)
    @route3 = @crag2.routes.create!(route_name: 'Verve', sport_route: true, trad_route: false, pitches: 1, grade: "5.13c")
    @route4 = @crag2.routes.create!(route_name: 'Cosmosis', sport_route: false, trad_route: true, pitches: 3, grade: "5.9")
  end

  describe "User Story 4" do
    it 'displays the route name' do

      visit "/routes/#{@route1.id}"

      expect(page).to have_content(@route1.route_name)
      expect(page).to_not have_content(@route2.route_name)
    end

    it 'displays the route information' do

      visit "/routes/#{@route3.id}"

      expect(page).to have_content(@route3.route_name)
      expect(page).to have_content(@route3.sport_route)
      expect(page).to have_content(@route3.trad_route)
      expect(page).to have_content(@route3.pitches)
      expect(page).to have_content(@route3.grade)
      expect(page).to have_content(@route3.created_at)
      expect(page).to have_content(@route3.updated_at)
      expect(page).to have_content(@route3.crag_id)
      expect(page).to_not have_content(@route1.route_name)
      expect(page).to_not have_content(@route2.route_name)
      expect(page).to_not have_content(@route4.route_name)
    end
  end

  describe 'link on page for /routes' do
    it 'has a link for /routes' do
      visit "/routes/#{@route3.id}"
      
      expect(page).to have_link("Routes")
    end
    
    it "when 'routes' link click, take user to /routes" do
      visit "/routes/#{@route3.id}"
      
      click_link "Routes"
      
      expect(current_path).to eq('/routes')
    end
  end
  
  describe 'User Story 20 deleting routes from show page' do
    it 'has a button to delete' do
      visit "/routes/#{@route1.id}"

      expect(page).to have_button("Delete #{@route1.route_name}")
    end

    it 'removes the crag and routes from site' do
      visit "/routes"

      expect(page).to have_content(@route1.route_name)

      visit "/routes/#{@route1.id}"

      click_button "Delete #{@route1.route_name}"

      expect(current_path).to eq("/routes")
      expect(page).to_not have_content(@route1.route_name)
      expect(page).to_not have_content(@route1.grade)
      expect(page).to have_content(@route3.route_name)
      expect(page).to have_content(@route3.grade)
    end
  end
end