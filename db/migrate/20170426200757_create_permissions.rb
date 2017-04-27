class CreatePermissions < ActiveRecord::Migration[5.0]
  def up
    create_table :permissions do |t|
      t.references :group, foreign_key: true
      t.references :control, foreign_key: true
      t.references :action, foreign_key: true
      t.text :description

      t.timestamps
    end
  end

  def down
  	drop_table :permissions  	
  end
end
