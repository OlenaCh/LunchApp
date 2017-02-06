class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string  'name'
      t.string  'address'
      t.string  'email'
      t.boolean 'email_msg_required'
      t.float   'total'
      t.string  'status'
      t.timestamps null: false
    end
  end
end
