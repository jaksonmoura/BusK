class AddSurroudingsToGoing < ActiveRecord::Migration
  def change
    add_column :goings, :surroundings, :string
  end
end
