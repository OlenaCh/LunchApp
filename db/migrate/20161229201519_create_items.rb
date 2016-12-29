class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :type, index: true
      t.string :title, null: false
      t.float  :price, null: false
      t.timestamps null: false
    end
  end
end
