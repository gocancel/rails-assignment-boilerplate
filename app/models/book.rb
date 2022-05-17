class Book < ApplicationRecord
  enum shelf: [ :read, :currently_reading, :want_to_read ]

  belongs_to :author

  has_one_attached :cover

  scope :by_shelf, -> shelf { where(shelf: shelf) }

  # validates :cover, attached: true, content_type: ["image/png", "image/jpeg"]
  validates :title, presence: true

  validates_associated :author
end
