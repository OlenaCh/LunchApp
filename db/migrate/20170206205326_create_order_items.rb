class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.belongs_to 'order'
      t.belongs_to 'item'
      t.integer    'amount'
      t.float      'total'
      t.timestamps null: false
    end
  end
end
