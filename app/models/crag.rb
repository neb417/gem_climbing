class Crag < ApplicationRecord
  has_many :routes, dependent: :destroy

  def count_routes
    routes.count
  end

  def self.route_count
    crags = Crag.all
    @ordered = crags.sort do |crag|
      crag.count_routes
    end.reverse
    @ordered
  end

end
