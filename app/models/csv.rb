class Csv < ApplicationRecord
  has_attached_file :csv, :path => 'app/storage/:id/:style/:filename'
  validates_attachment :csv, content_type: { content_type: "text/csv" }
end
