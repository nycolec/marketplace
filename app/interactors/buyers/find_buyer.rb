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

      context.fail!(error: 'Buyer not found', status: 404) unless context.buyer.present?
    end
  end
end
