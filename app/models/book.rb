# frozen_string_literal: true

class Book < ApplicationRecord
  enum shelf: %i[read currently_reading want_to_read]

  belongs_to :author

  has_one_attached :cover

  scope :by_shelf, ->(shelf) { where(shelf: shelf) }

  validates :title, presence: true
  validates :shelf, inclusion: { in: shelves.keys }
  validates :cover, presence: true, 
                    file_size: { min_size: 1.byte, max_size: 1.gigabyte },
                    file_type: { image: true, blacklist: ['image/svg+xml'] }
end
