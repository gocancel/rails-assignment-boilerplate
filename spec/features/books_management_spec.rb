# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Books creation', type: :feature do
  JPEG_PICTURE_PATH = Rails.root.join('spec/fixtures/files/very_nice_cat.jpeg')
  PDF_PICTURE_PATH = Rails.root.join('spec/fixtures/files/haha.pdf')

  scenario 'User creates a new book with a new author', js: true do
    visit books_path

    click_link 'Add a new book'

    expect(page).to have_text('Author missing? Add an author')
    author_name = 'Cat specialist'
    click_link 'Author missing? Add an author'

    fill_in 'Name of the author', with: author_name
    click_button 'Create Author'

    expect(page).to have_text(author_name)
    book_title = Faker::Book.title
    fill_in 'Title', with: book_title
    select 'Currently reading', from: 'book_shelf'
    attach_file('book_cover', JPEG_PICTURE_PATH)
    select author_name, from: 'book_author_id'
    click_button 'Create Book'

    created_book = Book.find_by(title: book_title)
    expect(page).to have_link(nil, href: book_path(created_book))
    expect(page).to have_css("img[src='#{rails_blob_path(created_book.cover)}']", count: 1)
  end

  scenario 'User tries to create empty author', js: true do
    visit books_path

    click_link 'Add a new book'

    expect(page).to have_text('Author missing? Add an author')
    click_link 'Author missing? Add an author'

    fill_in 'Name of the author', with: nil
    click_button 'Create Author'

    expect(page).to have_text("Name can't be blank")

    author_name = 'Cat specialist'
    fill_in 'Name of the author', with: author_name
    click_button 'Create Author'
    expect(page).to have_text(author_name)
  end

  scenario 'User tries to create book with invalid parameters', js: true do
    author = FactoryBot.create(:author)
    visit books_path

    click_link 'Add a new book'

    click_button 'Create Book'

    expect(page).to have_text("Title can't be blank")
    expect(page).to have_text("Cover can't be blank")

    book_title = Faker::Book.title
    fill_in 'Title', with: book_title
    select 'Currently reading', from: 'book_shelf'
    attach_file('book_cover', JPEG_PICTURE_PATH)
    select author.name, from: 'book_author_id'
    click_button 'Create Book'

    created_book = Book.find_by(title: book_title)
    expect(page).to have_link(nil, href: book_path(created_book))
    expect(page).to have_css("img[src='#{rails_blob_path(created_book.cover)}']", count: 1)
  end
  
  
    scenario 'User tries to submit a file that is not an image', js: true do
      author = FactoryBot.create(:author)
      visit books_path

      click_link 'Add a new book'

      click_button 'Create Book'

      expect(page).to have_text("Title can't be blank")
      expect(page).to have_text("Cover can't be blank")

      book_title = Faker::Book.title
      fill_in 'Title', with: book_title
      select 'Currently reading', from: 'book_shelf'
      attach_file('book_cover', PDF_PICTURE_PATH)
      select author.name, from: 'book_author_id'
      click_button 'Create Book'
      expect(page).to have_text("Cover file is not an image")
    end
end
