class CreateAttachments < ActiveRecord::Migration[5.0]
  def up
    create_table :attachments do |t|
      t.attachment :image
      t.references :product, foreign_key: true
      t.timestamps
    end
  end

  def down
  	drop_table :attachments
  end
end
