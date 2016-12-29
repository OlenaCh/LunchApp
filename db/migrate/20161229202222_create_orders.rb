class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.integer :first_course_id,  :default => 0
      t.integer :main_course_id,   :default => 0
      t.integer :drink_id,         :default => 0
      t.float   :total,            :default => 0, null: false
      t.timestamps null: false
    end
  end
end
