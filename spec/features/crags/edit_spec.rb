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
  end

  it 'links to the edit page' do
    visit "/crags/#{@crag1.id}"

    click_link  "Edit #{@crag1.crag_name}"
    expect(current_path).to eq("/crags/#{@crag1.id}/edit")
  end

  it 'can edit the crag' do
    crag1 = Crag.create!(crag_name: 'Esster', reservation_required: true, elevation: 6800)

    visit "/crags/#{crag1.id}"

    expect(page).to have_content('Esster')

    click_link "Edit Esster"

    expect(current_path).to eq("/crags/#{crag1.id}/edit")

    fill_in 'Crag Name', with: 'Easter Rock'
    choose 'No Reservation Required'
    fill_in 'Elevation', with: '5690'
    click_button 'Update Crag'

    expect(current_path).to eq("/crags/#{crag1.id}")
    expect(page).to have_content("Easter Rock")
    expect(page).to have_content(false)
    expect(page).to have_content(5690)
  end
end
