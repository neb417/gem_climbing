require 'rails_helper'

RSpec.describe Crag, type: :model do
  before :each do
    @crag1 = Crag.create!(crag_name: 'Redgarden Wall', reservation_required: true, elevation: 6800, created_at: "2022-08-25 14:28:59")
    @route1 = @crag1.routes.create!(route_name: 'Desdichado', sport_route: true, trad_route: false, pitches: 1, grade: "5.13d")
    @route2 = @crag1.routes.create!(route_name: 'Yellow Spur', sport_route: false, trad_route: true, pitches: 7, grade: "5.9")
    
    @crag2 = Crag.create!(crag_name: 'Bell Buttress', reservation_required: false, elevation: 7200, created_at: "2022-08-20 14:28:59")
    @route3 = @crag2.routes.create!(route_name: 'Verve', sport_route: true, trad_route: false, pitches: 1, grade: "5.13c")
    @route4 = @crag2.routes.create!(route_name: 'Cosmosis', sport_route: false, trad_route: true, pitches: 3, grade: "5.9")
    @route5 = @crag2.routes.create!(route_name: 'Arms Bazaar', sport_route: false, trad_route: true, pitches: 2, grade: "5.12a")

    @crag3 = Crag.create!(crag_name: 'The Dome', reservation_required: false, elevation: 5600)

    @all_crags = Crag.all
  end

  describe "relationships" do
    it { should have_many(:routes) }
  end

  describe "User Story 7 method count the routes a crag has" do
    it "counts routes" do
      expect(@crag1.count_routes).to eq(2)
    end
  end

  describe "**Extension 1** model method tests" do
    it "creates list of hashes to reference crag[id], number of routes with index position" do
      expect(@all_crags.route_count_hash).to eq([{id: @crag1.id, routes: 2, index: 0}, {id: @crag2.id, routes: 3, index: 1}, {id: @crag3.id, routes: 0, index: 2}])
    end

    it "sorts the hashes by value, number of routes" do
      sorted = @all_crags.route_count_hash
      expect(@all_crags.sort_crag_num_of_routes(sorted)).to eq([{id: @crag3.id, routes: 0, index: 2}, {id: @crag1.id, routes: 2, index: 0}, {id: @crag2.id, routes: 3, index: 1}])
    end

    it "lists all_crags in order by route count" do
      sorted = @all_crags.route_count_hash
      order = @all_crags.sort_crag_num_of_routes(sorted)

      expect(@all_crags.order_crag_num_of_routes(order)).to eq([@crag2, @crag1, @crag3])
    end

    it "returns order of the crags as desired" do
      expect(@all_crags.order_by_routes(@all_crags)).to eq([@crag2, @crag1, @crag3])
    end
  end
end