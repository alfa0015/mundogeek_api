class CreateControls < ActiveRecord::Migration[5.0]
  def change
    create_table :controls do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
  	drop_table :controls
  end
end
