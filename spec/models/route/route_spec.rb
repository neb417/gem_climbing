require 'rails_helper'

RSpec.describe Route, type: :model do
  before :each do
    @crag1 = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800, created_at: "2022-08-20 14:28:59")
    @route1 = @crag1.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")
    @route2 = @crag1.routes.create!(route_name: 'Yellow Spur', sport_route: false, trad_route: true, pitches: 7, grade: "5.9")

    @crag2 = Crag.create!(crag_name: 'Bell Buttress', reservation_required: false, elevation: 7200, created_at: "2022-08-25 14:28:59")
    @route3 = @crag2.routes.create!(route_name: 'Verve', sport_route: true, trad_route: false, pitches: 1, grade: "5.13c")
    @route4 = @crag2.routes.create!(route_name: 'Cosmosis', sport_route: false, trad_route: true, pitches: 3, grade: "5.9")
    
    @crag3 = Crag.create!(crag_name: 'The Dome', reservation_required: false, elevation: 5200)
    @route5 = @crag3.routes.create!(route_name: 'Umph Crack', sport_route: true, trad_route: false, pitches: 2, grade: "5.11")
  end

  describe "relationships" do
    it { should belong_to(:crag) }
  end

  describe 'validations' do
    it {should validate_presence_of :route_name}
    it {should validate_presence_of :pitches}
    it {should validate_presence_of :grade}
  end
end