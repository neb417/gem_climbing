class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.string :route_name
      t.boolean :sport_route
      t.boolean :trad_route
      t.integer :pitches
      t.string :grade
      t.references :crag, foreign_key: true

      t.timestamps
    end
  end
end
