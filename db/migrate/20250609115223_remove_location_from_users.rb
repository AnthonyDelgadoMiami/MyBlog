class RemoveLocationFromUsers < ActiveRecord::Migration[7.0]
  def change
    # Only remove the reference if it exists
    if foreign_key_exists?(:users, :locations)
      remove_reference :users, :location, null: false, foreign_key: true
    else
      # Just remove the column since there's no foreign key
      remove_column :users, :location_id, :integer
    end
  end
end
