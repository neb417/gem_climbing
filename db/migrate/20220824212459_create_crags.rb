class CreateCrags < ActiveRecord::Migration[5.2]
  def change
    create_table :crags do |t|
      t.string :crag_name
      t.boolean :reservation_required
      t.integer :elevation

      t.timestamps
    end
  end
end
