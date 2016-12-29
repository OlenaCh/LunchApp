class CreateWeekdays < ActiveRecord::Migration
  def change
    create_table :weekdays do |t|
      t.references :daily_order, polymorphic: true, index: true
      t.references :daily_menu, polymorphic: true, index: true
      t.string :day
      t.timestamps null: false
    end
  end
end
