class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.string :days_of_week

      t.timestamps
    end
  end
end
