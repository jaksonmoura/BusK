class RemoveStartTimeAndEndTimeFromLines < ActiveRecord::Migration
  def change
    remove_column :lines, :start_time, :time
    remove_column :lines, :end_time, :time
  end
end
