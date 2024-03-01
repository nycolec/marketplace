class BuyerMatcher < BaseMatcher
  def find_matches
    # Buyer.purchases.where.not(status: cancelled).group_by()
  end
end