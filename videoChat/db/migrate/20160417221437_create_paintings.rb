class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.string :name
      t.string :image
      t.references :room, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
