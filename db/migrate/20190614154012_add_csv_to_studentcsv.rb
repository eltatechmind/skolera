class AddCsvToStudentcsv < ActiveRecord::Migration[5.2]
  def change
    add_attachment :studentcsvs, :csv
  end
end
