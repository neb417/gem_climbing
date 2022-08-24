require 'rails_helper'

RSpec.describe Crag, type: :model do
  describe 'the index' do
    it 'shows the page with names only' do
      crag = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800)

      visit "/crags"
      # save_and_open_page
      expect(page).to have_content(crag.crag_name)
      expect(page).to_not have_content(crag.reservation_required)
      expect(page).to_not have_content(crag.elevation)
    end
  end
  
  describe "relationships" do
    xit { should have_many(:routes) }
  end
end