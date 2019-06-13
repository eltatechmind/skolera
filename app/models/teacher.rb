class Teacher < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 6, maximum: 35},
                   uniqueness: { case_sensitive: false }
  has_many :courses, dependent: :destroy

  def self.to_csv
    attributes = %w{id name}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |teacher|
        csv << attributes.map{ |attr| teacher.send(attr) }
      end
    end
  end
end
