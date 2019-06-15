class AddCsvToCsv < ActiveRecord::Migration[5.2]
  def change
    add_attachment :csvs, :csv
  end
end
