class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :title,   null: false
      t.string :address, null: false
      t.string :phone,   null: false
      t.string :email,   null: false
      t.timestamps null: false
    end
  end
end
