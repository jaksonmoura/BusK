class CreateReturns < ActiveRecord::Migration
  def change
    create_table :returns do |t|
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
