class AddGroupRelationShipToUsers < ActiveRecord::Migration[5.0]
  def up
    add_reference :users, :group, foreign_key: true,default: 2
  end

  def down
  	remove_reference :users, :group, foreign_key: true
  end
end
