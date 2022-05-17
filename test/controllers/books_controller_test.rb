require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "book succesfully created" do

    assert_difference 'Book.count' do
      post :create, params: { book: {
        title: "1984",
        shelf: "read",
        cover: File.open(Rails.root.join('/db/seeds/cover_1984.png')),
        name: "George Orwell"
      }}
    end

  end

  test "failed to create book without title" do

    assert_difference 'Book.count', 0 do
      post :create, params: { book: {
        shelf: "read",
        cover: File.open(Rails.root.join('/db/seeds/cover_1984.png')),
        name: "George Orwell"
      }}
    end

  end
end
