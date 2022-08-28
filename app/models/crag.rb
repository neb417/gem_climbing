class Crag < ApplicationRecord
  has_many :routes, dependent: :destroy

  def count_routes
    routes.count
  end
end
