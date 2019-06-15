class Csv < ApplicationRecord
  has_attached_file :csv, :path => 'public/system/csvs/csvs/000/000/:id/:style/:filename'
  validates_attachment :csv, content_type: { content_type: "text/csv" }
end
