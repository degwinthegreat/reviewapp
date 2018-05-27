class CreateEstimates < ActiveRecord::Migration[5.1]
  def change
    create_table :estimates do |t|
      t.integer :user_id
      t.integer :citicize_id
      t.integer :rate

      t.references :user
      t.references :citicize
      t.timestamps
    end
  end
end
