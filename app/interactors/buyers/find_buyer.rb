# frozen_string_literal: true

module Buyers
  class FindBuyer
    include Interactor

    before do
      context.buyer_id ||= context.params[:buyer]
    end

    def call
      context.buyer = Buyer.find(context.buyer_id)
      p 'hi', context.buyer
      # in production scenario dealing with authenticated users, id
      # most likely return 404 - due to security concerns
      context.fail!(message: 'Buyer not found', status: 403) unless context.buyer.present?
    end
  end
end
