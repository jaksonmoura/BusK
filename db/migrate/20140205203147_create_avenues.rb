class CreateAvenues < ActiveRecord::Migration
  def change
    create_table :avenues do |t|
      t.string :avenue

      t.timestamps
    end
  end
end
