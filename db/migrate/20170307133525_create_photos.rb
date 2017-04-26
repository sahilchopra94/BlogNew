class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.integer :article_id
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
