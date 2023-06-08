class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :interval_in_minute, :integer
    add_column :users, :last_search, :datetime
  end
end
