class CreateStudentcsvs < ActiveRecord::Migration[5.2]
  def change
    create_table :studentcsvs do |t|

      t.timestamps
    end
  end
end
