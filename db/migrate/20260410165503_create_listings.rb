class CreateListings < ActiveRecord::Migration[8.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :price
      t.references :creator, null: true, foreign_key: { to_table: :users }
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
