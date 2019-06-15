class CreateCsvs < ActiveRecord::Migration[5.2]
  def change
    create_table :csvs do |t|
      t.string :kind
      t.timestamps
    end
  end
end
