class AddUserToEvent < ActiveRecord::Migration
  def change
	  add_column :events, :user_id, :integer, :null => true
  end
end
