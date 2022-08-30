class Crag < ApplicationRecord
  has_many :routes, dependent: :destroy
  validates :crag_name, presence: true
  validates :reservation_required, inclusion: [true, false]
  validates :reservation_required, exclusion: [nil]
  validates :elevation, presence: true, numericality: { only_integer: true }

  def count_routes
    routes.count
  end

  def self.order_by_routes(crags_to_order)
    sorted = crags_to_order.route_count_hash(crags_to_order)
    ordered = crags_to_order.sort_crag_num_of_routes(sorted)
    @crags = crags_to_order.order_crag_num_of_routes(ordered)
  end

  def self.route_count_hash(crags_to_order)
    crag_list = []
    @all_crags = crags_to_order.each_with_index do |crag, index|
      crag_routes = {}
      crag_routes[:id] = crag.id
      crag_routes[:routes] = crag.count_routes
      crag_routes[:index] = index
      crag_list << crag_routes
    end
    crag_list
  end

  def self.sort_crag_num_of_routes(crags_to_sort)
    crags_to_sort.sort_by do |crag|
      crag[:routes]
    end
  end

  def self.order_crag_num_of_routes(crags_to_order)
    sorted_crags = []
    crags_to_order.each do |item|
      sorted_crags << @all_crags[item[:index]]
    end
    sorted_crags.reverse
  end
end
