# frozen_string_literal: true

module Buyers
  class FindBuyer
    include Interactor

    before do
      context.buyer_id ||= context.params[:buyer]
    end

    def call
      # find_by is good for prevent SQL injection as we use the buyer object later
      # for finding matches
      context.buyer = Buyer.find_by(id: context.buyer_id)

      # in production scenario dealing with authenticated users, id
      # most likely return 404 - due to security concerns
      context.fail!(error: 'Buyer not found', status: 403) unless context.buyer.present?
    end
  end
end
