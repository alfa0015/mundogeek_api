class CreateProducts < ActiveRecord::Migration[5.0]
  def up
    create_table :products do |t|
      t.string :name
      t.decimal :pricing
      t.string :description
      t.string :status
      t.date :expired
      t.integer :stock

      t.timestamps
    end
  end

  def down
    drop_table :products
  end
end
