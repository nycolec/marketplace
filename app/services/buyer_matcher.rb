# frozen_string_literal: true

# Buyer matcher class returns a list of sellers the buyer might
# be interested in based on their past purchases
class BuyerMatcher
  def initialize(buyer:)
    @buyer = buyer
  end

  def find_matches
    purchases = get_purchases_for_buyer(@buyer)
    find_sellers_for_buyer(purchases)
  end

  private

  def matching_produce_numbers?(purchase1, purchase2)
    purchase1['produce_id'] == purchase2['produce_id']
  end

  def within_14_days?(end_date, start_date)
    (end_date - start_date).to_int <= 14
  end

  def find_sellers_for_buyer(purchases)
    seller_list = []
    seller_cache = {}
    purchases.each_with_index do |purchase, idx|
      break if idx + 1 == purchases.to_a.length

      future_purchase = purchases[idx + 1]

      next unless matching_produce_numbers?(purchase, future_purchase) &&
                  within_14_days?(purchase['date_purchased'].to_date, future_purchase['date_purchased'].to_date)

      seller = { name: purchase['name'], id: purchase['seller_id'] }
      seller2 = { name: future_purchase['name'], id: future_purchase['seller_id'] }

      # prevent seller showing up mutliple times in recommendations list
      seller_list << seller unless seller_cache[seller['seller_id']]
      seller_cache[seller['seller_id']] = idx

      seller_list << seller2 unless seller_cache[seller2['seller_id']]
      seller_cache[seller2['seller_id']] = idx + 1
    end

    seller_list
  end

  def get_purchases_for_buyer(buyer)
    purchases = ActiveRecord::Base.connection.execute(
      "SELECT purchases.produce_id, purchases.date_purchased, sellers.name, purchases.seller_id, purchases.id
        FROM purchases
        INNER JOIN sellers ON purchases.seller_id = sellers.id
        WHERE purchases.buyer_id = #{buyer.id} AND purchases.status <> 1
        ORDER BY purchases.produce_id DESC, purchases.date_purchased DESC"
    )

    purchases.to_a
  end
end
