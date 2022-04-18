require 'faker'

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    shelf { Book.shelves.keys.sample }
    association :author, factory: :author
    after(:build) do |book|
      book.cover.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/very_nice_cat.jpeg')),
        filename: 'test.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
