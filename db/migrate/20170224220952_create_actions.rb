class CreateActions < ActiveRecord::Migration[5.0]
  def up
    create_table :actions do |t|
      t.string :name
      t.references :control, foreign_key: true

      t.timestamps
    end
  end

  def down
  	drop_table :actions
  end
end
