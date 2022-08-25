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
  
  it 'displays the crag name' do
    visit "/crags"

    expect(page).to have_content(@crag1.crag_name)
    expect(page).to have_content(@crag2.crag_name)
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
end