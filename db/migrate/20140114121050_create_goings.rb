class CreateGoings < ActiveRecord::Migration
  def change
    create_table :goings do |t|
      t.string :start_location
      t.string :end_location
      t.string :waypoints
      t.string :blocks_passed
      t.integer :downvotes
      t.references :line, index: true

      t.timestamps
    end
  end
end
