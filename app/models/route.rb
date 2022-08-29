class Route < ApplicationRecord
 belongs_to :crag
 validates :route_name, presence: true
 validates :sport_route, inclusion: [true, false]
 validates :sport_route, exclusion: [nil]
 validates :trad_route, inclusion: [true, false]
 validates :trad_route, exclusion: [nil]
 validates :pitches, presence: true, numericality: { only_integer: true }
 validates :grade, presence: true

end