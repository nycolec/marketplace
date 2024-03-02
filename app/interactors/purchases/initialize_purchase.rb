# frozen_string_literal: true

module Purchases
  class InitializePurchase
    include Interactor

    def call
      context.purchase = Purchase.new
    end
  end
end
