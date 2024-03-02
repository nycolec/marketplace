# frozen_string_literal: true

module Purchases
  class FindMatchesForBuyer
    include Interactor

    def call
      context.matches = BuyerMatcher.new(buyer: context.buyer).find_matches
    end
  end
end
