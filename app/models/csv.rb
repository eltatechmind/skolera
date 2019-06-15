class Csv < ApplicationRecord
  if Rails.env.production?
    has_attached_file :raw, :storage => :cloudinary, :path => 'public/system/csvs/csvs/000/000/:id/:style/:filename'
  else
    has_attached_file :csv, :path => 'public/system/csvs/csvs/000/000/:id/:style/:filename'
  end
  validates_attachment :csv, content_type: { content_type: "text/csv" }
end
