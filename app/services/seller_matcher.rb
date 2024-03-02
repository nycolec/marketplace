# frozen_string_literal: true

class SellerMatcher
  def initialize(seller:)
    @seller = seller
  end

  def find_matches
    get_purchases_for_seller(@seller)
  end

  private

  def get_purchases_for_seller(seller)
    # capture customers that have purchased from the seller more than two times
    matches = ActiveRecord::Base.connection.execute(
      "SELECT COUNT(purchases.buyer_id) AS buyer_count, purchases.buyer_id, buyers.name
        FROM purchases
        INNER JOIN buyers ON purchases.buyer_id = buyers.id
        WHERE purchases.seller_id = #{seller} AND purchases.status <> 1
        GROUP BY purchases.buyer_id, buyers.name
        HAVING COUNT(purchases.buyer_id) > 2
        ORDER BY buyer_count DESC"
    )

    matches.to_a
  end
end
