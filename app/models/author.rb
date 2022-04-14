class Author < ApplicationRecord
  has_many :books
  
  validates :name, presence: true
  after_create_commit { broadcast_prepend_to "authors" }
end
