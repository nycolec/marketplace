# frozen_string_literal: true

module Purchases
  class SavePurchase
    include Interactor

    def call
      context.purchase.save!
    end
  end
end
