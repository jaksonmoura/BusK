class CreateBusstops < ActiveRecord::Migration
  def change
    create_table :busstops do |t|
      t.string :name
      t.string :lat
      t.string :lng
      t.integer :kind

      t.timestamps
    end
  end
end
