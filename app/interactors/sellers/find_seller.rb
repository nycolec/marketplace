# frozen_string_literal: true

module Sellers
  class FindSeller
    include Interactor

    before do
      context.seller_id ||= context.params[:seller]
    end

    def call
      p '3'
      context.seller = Seller.find(context.seller_id)

      # in production scenario dealing with authenticated users, id
      # most likely return 404 - due to security concerns
      context.fail!(message: 'Seller not found', status: 403) unless context.seller.present?
    end
  end
end
