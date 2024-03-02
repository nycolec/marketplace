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

  def matching_produce_numbers?(produce1, produce2)
    produce1 == produce2
  end

  def within_14_days?(end_date, start_date)
    (end_date - start_date).to_int <= 14
  end

  def find_sellers_for_buyer(purchases)
    seller_list = []
    seller_cache = {}
    purchases.each_with_index do |purchase, idx|
      break if idx + 1 == purchases.to_a.length

      future_idx = purchases[idx + 1]

      next unless matching_produce_numbers?(purchase['produce_id'], future_idx['produce_id']) &&
                  within_14_days?(purchase['date_purchased'].to_date, future_idx['date_purchased'].to_date)

      seller = { name: purchase['name'], id: purchase['seller_id'] }
      seller2 = { name: future_idx['name'], id: future_idx['seller_id'] }

      # prevent seller showing up mutliple times in recommendations list
      seller_list << seller unless seller_cache[seller['name']]
      seller_list << seller2

      seller_cache[seller['name']] = idx
      seller_cache[seller2['name']] = idx + 1
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
