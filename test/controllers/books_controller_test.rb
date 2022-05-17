require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "book succesfully created" do
    expect {
      post books_path,
           :book => {
             title: "1984",
             shelf: "read",
             cover: File.open(Rails.root.join('/db/seeds/cover_1984.png')),
             name: "George Orwell"
           }
    }.to change(Book, :count).by(1)

  end
end
