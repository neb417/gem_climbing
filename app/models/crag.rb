class Crag < ApplicationRecord
 has_many :routes
 
 def count_routes
    routes.count
  end
end