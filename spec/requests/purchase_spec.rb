# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Purchases', type: :request do
  describe 'POST /api/v1/purchases' do
    context 'when params are invalid' do
      let(:invalid_params) do
        {
          purchase: {
            # use factory bot to scale
            seller: Seller.create(name: Faker::Name.name).id,
            buyer: Buyer.create(name: Faker::Name.name).id,
            produce: 'Cereal'
          }
        }
      end

      it 'returns 404' do
        post '/api/v1/purchases', params: invalid_params
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when params are valid' do
      let(:fruit) { Produce.create(produce_type: 'Apple') }
      let(:valid_params) do
        {
          purchase: {
            #  use factory bot to scale
            seller: Seller.create(name: Faker::Name.name).id,
            buyer: Buyer.create(name: Faker::Name.name).id,
            produce: fruit.produce_type,
            status: :completed
          }
        }
      end

      it 'returns http success' do
        post '/api/v1/purchases', params: valid_params
        expect(response).to have_http_status(:created)
      end
    end
  end
end
