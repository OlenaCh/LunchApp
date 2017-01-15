class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string  'weekday'
      t.integer 'f_course_id_1'
      t.integer 'f_course_id_2'
      t.integer 'f_course_id_3'
      t.integer 'f_course_id_4'
      t.integer 'm_course_id_1'
      t.integer 'm_course_id_2'
      t.integer 'm_course_id_3'
      t.integer 'm_course_id_4'
      t.integer 'drink_id_1'
      t.integer 'drink_id_2'
      t.integer 'drink_id_3'
      t.integer 'drink_id_4'
      t.timestamps null: false
    end
  end
end
