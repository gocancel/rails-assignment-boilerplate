# frozen_string_literal: true

module BooksHelper
  def data_for_shelf_select
    Book.shelves.keys.to_a.map(&:humanize).zip(Book.shelves.keys.to_a)
  end
end
