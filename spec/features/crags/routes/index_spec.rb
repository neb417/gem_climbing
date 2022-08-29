require 'rails_helper'

RSpec.describe 'crag/routes show page' do
  before :each do
    @crag1 = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800)
    @route1 = @crag1.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")
    @route2 = @crag1.routes.create!(route_name: 'Yellow Spur', sport_route: false, trad_route: true, pitches: 7, grade: "5.9")

    @crag2 = Crag.create!(crag_name: 'Bell Buttress', reservation_required: false, elevation: 7200)
    @route3 = @crag2.routes.create!(route_name: 'Verve', sport_route: true, trad_route: false, pitches: 1, grade: "5.13c")
    @route4 = @crag2.routes.create!(route_name: 'Cosmosis', sport_route: false, trad_route: true, pitches: 3, grade: "5.9")
  end
  
  describe 'User Story 5' do
    it 'displays the crag name' do
      visit "/crags/#{@crag1.id}/routes"

      expect(page).to have_content(@crag1.crag_name)
      expect(page).to_not have_content(@crag2.crag_name)
    end

    it 'displays the routes information' do

      visit "/crags/#{@crag2.id}/routes"

      expect(page).to have_content(@route3.route_name)
      expect(page).to have_content(@route3.sport_route)
      expect(page).to have_content(@route3.trad_route)
      expect(page).to have_content(@route4.pitches)
      expect(page).to have_content(@route4.grade)
      expect(page).to have_content(@route4.created_at)
      expect(page).to have_content(@route4.updated_at)
      expect(page).to_not have_content(@route1.route_name)
      expect(page).to_not have_content(@route2.route_name)
    end
  end

  describe 'link on page for /routes' do
    it 'has a link for /routes' do
      visit "/crags/#{@crag1.id}"

      expect(page).to have_link("Routes")
    end

    it "when 'routes' link click, take user to /routes" do
      visit "/crags/#{@crag2.id}"

      click_link "Routes"

      expect(current_path).to eq('/routes')
    end
  end

  describe 'User Story 16 link on page to alphabetize routes' do
    it 'has a link to alphabetize' do
      visit "/crags/#{@crag1.id}/routes"

      expect(page).to have_link("Alphabetize Routes")
    end

    it "alphabetize link click, index page in alphabetical order" do
      visit "/crags/#{@crag2.id}/routes"

      click_link "Alphabetize Routes"

      expect(current_path).to eq("/crags/#{@crag2.id}/routes")
      expect(@route4.route_name).to appear_before(@route3.route_name)
    end
  end
  
  describe 'User Story 21 input field to submit minimum pitches for crag' do
    it 'the input field is there with submit button' do
      visit "/crags/#{@crag1.id}/routes"

      expect(page).to have_content("Minimum number of pitches")
      expect(page).to have_button("Submit")
    end

    it 'filter the pitches and returns crags with pitches >= input' do
      visit "/crags/#{@crag1.id}/routes"
      
      fill_in "Minimum number of pitches", with: 2
      
      click_button "Submit"
      
      expect(page).to have_content(@route2.route_name)
      expect(page).to_not have_content(@route1.route_name)

      visit "/crags/#{@crag1.id}/routes"
      
      fill_in "Minimum number of pitches", with: 12

      click_button "Submit"
      
      expect(page).to_not have_content(@route2.route_name)
      expect(page).to_not have_content(@route1.route_name)
    end
  end
end