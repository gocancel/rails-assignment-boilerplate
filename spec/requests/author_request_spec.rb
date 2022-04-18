require 'rails_helper'

RSpec.describe 'Author', type: :request do
  describe 'POST /create' do
    subject { post authors_url, params: params }

    let(:params) { { author: { name: Faker::Book.author } } }

    context 'with valid parameters' do
      it 'creates a new author' do
        expect { subject }.to change(Author, :count).by(1)
      end

      it 'redirects to the created author' do
        subject
        expect(response).to redirect_to(author_url(Author.last))
      end
    end

    context 'with invalid parameters' do
      let(:params) { { author: { name: nil } } }

      it 'does not create a new author' do
        expect { subject }.to change(Author, :count).by(0)
      end

      it 'returns a successful response' do
        subject
        expect(response.status).to eq(200)
      end
    end
  end
end
