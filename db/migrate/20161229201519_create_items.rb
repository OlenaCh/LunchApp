class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_type, null: false
      t.string :title,     null: false
      t.float  :price,     null: false
      t.string :image
      t.string :description
      t.string :fat
      t.string :carbohydrate
      t.string :protein
      t.string :calorie
      t.string :net_weight
      t.timestamps null: false
    end
  end
end
