class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.belongs_to :order, index: true
      t.belongs_to :item,  index: true
      t.integer    :amount
      t.float      :total
      t.timestamps null: false
    end
  end
end