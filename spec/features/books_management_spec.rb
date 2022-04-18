# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Books creation', type: :feature do
  JPEG_PICTURE_PATH = Rails.root.join('spec/fixtures/files/very_nice_cat.jpeg')

  scenario 'User creates a new book with a new author', js: true do
    visit books_path

    click_link 'Add a new book'

    expect(page).to have_text('Author missing? Add an author')
    author_name = 'Cat specialist'
    click_link 'Author missing? Add an author'

    fill_in 'Name of the author', with: author_name
    click_button 'Create Author'

    expect(page).to have_text(author_name)
    fill_in 'Title', with: 'The great book of cats'
    select 'Currently reading', from: 'book_shelf'
    attach_file('book_cover', JPEG_PICTURE_PATH)
    select author_name, from: 'book_author_id'
    click_button 'Create Book'

    created_book = Book.find_by(title: 'The great book of cats')
    expect(page).to have_link(nil, href: book_path(created_book))
    expect(page).to have_css("img[src='#{rails_blob_path(created_book.cover)}']", count: 1)
  end
end
