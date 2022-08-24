require 'rails_helper'

RSpec.describe 'routes show page' do
  it 'displays the route name' do
    crag = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800)
    route = crag.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")

    visit "/routes/#{route.id}"

    expect(page).to have_content(route.route_name)
  end

  it 'displays the route information' do
    crag = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800)
    route = crag.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")

    visit "/routes/#{route.id}"


    expect(page).to have_content(route.route_name)
    expect(page).to have_content(route.sport_route)
    expect(page).to have_content(route.trad_route)
    expect(page).to have_content(route.pitches)
    expect(page).to have_content(route.grade)
    expect(page).to have_content(route.created_at)
    expect(page).to have_content(route.updated_at)
    expect(page).to have_content(route.crag_id)
    binding.pry
  end
end