class FindBuyerMatches
  include Interactor

  def call
    context.matches = BuyerMatcher.new(seller: context.seller)
  end
end
