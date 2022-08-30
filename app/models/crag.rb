class Crag < ApplicationRecord
  has_many :routes, dependent: :destroy
  validates :crag_name, presence: true
  validates :reservation_required, inclusion: [true, false]
  validates :reservation_required, exclusion: [nil]
  validates :elevation, presence: true, numericality: { only_integer: true }

  def count_routes
    routes.count
  end

  def self.route_count
    crags = Crag.all
    # crags_by_routes = []
    # crags.each do |crag|
    #   test = {}
    #   test[crag.id] = crag.count_routes
    #   crags_by_routes << test
    # end
    # sorted = crags_by_routes.sort_by { |k, v| v }
    # binding.pry
    # try = sorted.reverse
    ordered = []
    list = crags.each_with_index do |crag, index|
      crag_routes = {}
      crag_routes["id"] = crag.id
      crag_routes["routes"] = crag.count_routes
      crag_routes["index"] = index
      ordered << crag_routes
    end
    sorted = ordered.sort_by { |k| k["routes"] }
    sorted_crags = []
    sorted.each do |item|
      sorted_crags << crags[item["index"]]
    end
    sorted_crags.reverse
    # binding.pry
  end
end
