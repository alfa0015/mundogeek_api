class CreateTokens < ActiveRecord::Migration[5.0]
  def up
    create_table :tokens do |t|
      t.string :token
      t.datetime :expires_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end

  def down
  	drop_table :tokens
  end
end
