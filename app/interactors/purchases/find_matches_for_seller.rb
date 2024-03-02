# frozen_string_literal: true

module Purchases
  class FindMatchesForSeller
    include Interactor

    def call
      context.matches = SellerMatcher.new(buyer: context.seller).find_matches
    end
  end
end
