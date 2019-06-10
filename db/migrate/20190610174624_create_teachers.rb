class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
