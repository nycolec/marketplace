# frozen_string_literal: true

module Sellers
  class FindSeller
    include Interactor

    before do
      context.seller_id ||= context.params[:seller]
    end

    def call
      context.seller = Seller.find_by(id: context.seller_id)

      context.fail!(error: 'Seller not found', status: 404) unless context.seller.present?
    end
  end
end
