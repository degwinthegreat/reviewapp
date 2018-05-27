class CreateCiticizes < ActiveRecord::Migration[5.1]
  def change
    create_table :citicizes do |t|
      t.string :title
      t.text :content
      t.string :album
      t.string :artist
      t.string :artwork
      t.integer :estimate

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
