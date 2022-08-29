require 'rails_helper'

RSpec.describe 'crags index page' do
  before :each do
    @crag1 = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800, created_at: "2022-08-20 14:28:59")
    @route1 = @crag1.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")
    @route2 = @crag1.routes.create!(route_name: 'Yellow Spur', sport_route: false, trad_route: true, pitches: 7, grade: "5.9")

    @crag2 = Crag.create!(crag_name: 'Bell Buttress', reservation_required: false, elevation: 7200, created_at: "2022-08-25 14:28:59")
    @route3 = @crag2.routes.create!(route_name: 'Verve', sport_route: true, trad_route: false, pitches: 1, grade: "5.13c")
    @route4 = @crag2.routes.create!(route_name: 'Cosmosis', sport_route: false, trad_route: true, pitches: 3, grade: "5.9")
    route5 = @crag2.routes.create!(route_name: 'Arms Bazaar', sport_route: false, trad_route: true, pitches: 2, grade: "5.12a")

    @crag3 = Crag.create!(crag_name: 'The Dome', reservation_required: false, elevation: 5200)
  end

  describe 'User Story 1 list on page' do
    it 'displays the crag name' do
      visit '/crags'

      expect(page).to have_content(@crag1.crag_name)
      expect(page).to have_content(@crag2.crag_name)
    end
  end

  describe "User Story 6" do
    it 'sorts the crags by most recently created' do
      visit "/crags"

      expect(@crag2.crag_name).to appear_before(@crag1.crag_name)
    end
  end

  describe 'link on page for /routes' do
    it 'has a link for /routes' do
      visit "/crags/#{@crag1.id}/routes"

      expect(page).to have_link('Routes')
    end

    it "when 'routes' link click, take user to /routes" do
      visit "/crags/#{@crag2.id}/routes"

      click_link 'Routes'

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

  describe 'link on page for crag/:id' do
    it 'has a link for crag/:id' do
      visit "/crags"

      expect(page).to have_link("#{@crag1.crag_name}")
      expect(page).to have_link("#{@crag2.crag_name}")
    end

    it "when 'Routes for Crag' link click, take user to crag/:id/routes" do
      visit "/crags"
      click_link "#{@crag2.crag_name}"

      expect(current_path).to eq("/crags/#{@crag2.id}")
    end
  end

  describe 'User Story 17 edit capabilities for crags' do
    it 'links to the edit page' do
      visit "/crags"
      
      expect(page).to have_link("Edit #{@crag1.crag_name}")
      expect(page).to have_link("Edit #{@crag3.crag_name}")
      expect(page).to have_link("Edit #{@crag2.crag_name}")

      click_link "Edit The Dome"

      expect(current_path).to eq("/crags/#{@crag3.id}/edit")
    end
  end

  describe 'User Story 22 deleting crags from show page' do
    it 'has a button to delete' do
      visit "/crags"

      expect(page).to have_button("Delete #{@crag1.crag_name} and Routes")
      expect(page).to have_button("Delete #{@crag2.crag_name} and Routes")
      expect(page).to have_button("Delete #{@crag3.crag_name} and Routes")
    end

    it 'removes the crag and routes from site' do
      visit "/routes"
      
      expect(page).to have_content(@route1.route_name)
      expect(page).to have_content(@route3.route_name)

      visit "/crags"

      expect(page).to have_content(@crag1.crag_name)
      expect(page).to have_content(@crag1.reservation_required)
      expect(page).to have_content(@crag1.elevation)
      expect(page).to have_content(@crag2.crag_name)
      expect(page).to have_content(@crag2.reservation_required)
      expect(page).to have_content(@crag2.elevation)
      expect(page).to have_content(@crag3.crag_name)
      expect(page).to have_content(@crag3.reservation_required)
      expect(page).to have_content(@crag3.elevation)

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

  describe '**Extension 1** Sort crags by number of routes' do
    it 'has a link to sort routes' do
      visit "/crags"

      expect(page).to have_link("Order Crags by number of Routes")

      click_link "Order Crags by number of Routes"

      expect(current_path).to eq("/crags")
    end

    it 'sorts routes by number of routes, high to low' do
      route5 = @crag2.routes.create!(route_name: 'Arms Bazaar', sport_route: false, trad_route: true, pitches: 2, grade: "5.12a")

      visit "/crags"

      click_link "Order Crags by number of Routes" 

      expect(@crag2.crag_name).to appear_before(@crag1.crag_name)
      expect(@crag1.crag_name).to appear_before(@crag3.crag_name)
    end
  end
end