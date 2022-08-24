require 'rails_helper'

RSpec.describe 'crags show page' do
  it 'displays the crag name' do
    crag = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800)
    visit "/crags/#{crag.id}"

    expect(page).to have_content(crag.crag_name)
  end

  it 'displays the crag information' do
    crag = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800)
    visit "/crags/#{crag.id}"

    expect(page).to have_content(crag.crag_name)
    expect(page).to have_content(crag.reservation_required)
    expect(page).to have_content(crag.elevation)
  end
end