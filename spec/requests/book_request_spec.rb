require 'rails_helper'

RSpec.describe 'Book', type: :request do
  RSpec.shared_examples 'successful response' do |_parameter|
    it 'returns a successful response' do
      subject
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /index' do
    subject { get books_path }

    context 'when no book records are available' do
      it_behaves_like 'successful response'
    end

    context "when there's a collection of books" do
      before do
        10.times do
          FactoryBot.create(:book, shelf: 'currently_reading')
        end
        5.times do
          FactoryBot.create(:book, shelf: 'read')
        end
      end

      it_behaves_like 'successful response'

      context 'when filtered by shelf' do
        it 'renders a successful response' do
          get books_path(shelf: 'currently_reading')
          expect(response.status).to eq(200)
        end

        it 'filters books by shelf' do
          get books_path(shelf: 'currently_reading')
          expect(response.body.scan('img').size).to eq(10)
        end
      end
    end
  end

  describe  'GET /new' do
    subject { get new_book_path }

    it_behaves_like 'successful response'
  end

  describe 'POST /create' do
    subject { post books_url, params: params }

    let(:params) do
      { book: { author_id: author_id,
                shelf: shelf,
                title: title,
                cover: cover } }
    end
    let(:author_id) { FactoryBot.create(:author).id }
    let(:shelf) { Book.shelves.keys.sample }
    let(:title) { Faker::Book.title }
    let(:cover) { fixture_file_upload(file_fixture('very_nice_cat.jpeg'), 'image/jpeg') }

    context 'with valid parameters' do
      it 'creates a new Book' do
        expect { subject }.to change(Book, :count).by(1)
      end

      it 'redirects to the created book' do
        subject
        expect(response).to redirect_to(book_url(Book.last))
      end
    end

    context 'with invalid parameters' do
      let(:title) { nil }

      it 'does not create a new Book' do
        expect { subject }.to change(Book, :count).by(0)
      end

      it_behaves_like 'successful response'

      context 'with invalid file format' do
        let(:cover) { fixture_file_upload(file_fixture('haha.pdf'), 'application/pdf') }

        it 'does not create a new Book' do
          expect { subject }.to change(Book, :count).by(0)
        end

        it_behaves_like 'successful response'
      end

      context 'with disguised wrong file format' do
        let(:cover) { fixture_file_upload(file_fixture('haha.pdf'), 'image/jpeg') }

        it 'does not create a new Book' do
          expect { subject }.to change(Book, :count).by(0)
        end

        it_behaves_like 'successful response'
      end
    end
  end
end
