class CreateActionsControls < ActiveRecord::Migration[5.0]
  def up
    create_table :actions_controls do |t|
      t.references :action, foreign_key: true
      t.references :control, foreign_key: true

      t.timestamps
    end
  end

  def down
  	drop_table :actions_controls
  end
end
