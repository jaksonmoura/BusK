class AddSurroudingsToReturn < ActiveRecord::Migration
  def change
    add_column :returns, :surroundings, :string
  end
end
