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
end