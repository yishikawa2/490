class AddPublicToPainting < ActiveRecord::Migration
  def change
    add_column :paintings, :public, :boolean
  end
end
