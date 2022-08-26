require 'rails_helper'

RSpec.describe 'crags show page' do
  before :each do
    @crag1 = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800, created_at: "2022-08-20 14:28:59")
    @route1 = @crag1.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")
    @route2 = @crag1.routes.create!(route_name: 'Yellow Spur', sport_route: false, trad_route: true, pitches: 7, grade: "5.9")
    
    @crag2 = Crag.create!(crag_name: 'Bell Buttress', reservation_required: false, elevation: 7200, created_at: "2022-08-25 14:28:59")
    @route3 = @crag2.routes.create!(route_name: 'Verve', sport_route: true, trad_route: false, pitches: 1, grade: "5.13c")
    @route4 = @crag2.routes.create!(route_name: 'Cosmosis', sport_route: false, trad_route: true, pitches: 3, grade: "5.9")
  end
  
  describe "list on page" do
    it 'displays the crag name' do
      visit "/crags"
      
      expect(page).to have_content(@crag1.crag_name)
      expect(page).to have_content(@crag2.crag_name)
    end

    it 'sorts the crags by most recently created' do
      visit "/crags"

      expect(@crag2.crag_name).to appear_before(@crag1.crag_name)
    end
  end 
  
  describe 'link on page for /routes' do
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

  describe 'link on page for crag/:id/routes' do
    it 'has a link for crag/:id/routes' do
      visit "/crags/#{@crag1.id}"
      
      expect(page).to have_link("Routes for #{@crag1.crag_name}")
    end
    
    it "when 'Routes for Crag' link click, take user to crag/:id/routes" do
      visit "/crags/#{@crag2.id}"
      click_link "Routes for #{@crag2.crag_name}"

      expect(current_path).to eq("/crags/#{@crag2.id}/routes")
    end
  end
end