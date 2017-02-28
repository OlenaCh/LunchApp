class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_type, null: false
      t.string :title,     null: false
      t.float  :price,     null: false
      t.string :image
      t.string :description
      t.float  :fat
      t.float  :carbohydrate
      t.float  :protein
      t.float  :calorie
      t.float  :net_weight
      t.timestamps null: false
    end
  end
end
