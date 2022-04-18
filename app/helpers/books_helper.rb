# frozen_string_literal: true

module BooksHelper
  def data_for_shelf_select
    shelf_names = Book.shelves.keys.to_a
    shelf_names.map(&:humanize).zip(shelf_names)
  end
end
