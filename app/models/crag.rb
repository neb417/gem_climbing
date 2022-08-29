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
    @ordered = crags.sort do |crag|
      crag.count_routes
    end.reverse
    @ordered
  end

end
