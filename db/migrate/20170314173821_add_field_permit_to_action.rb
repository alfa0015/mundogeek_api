class AddFieldPermitToAction < ActiveRecord::Migration[5.0]
  def up
    add_column :actions, :permit, :boolean
  end

  def down
  	remove_column :actions, :permit, :boolean
  end
end
