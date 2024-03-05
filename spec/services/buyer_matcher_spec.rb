# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BuyerMatcher do
  describe 'creation' do
    buyer = 'John Doe'

    it 'instantiates the class' do
      expect(described_class.new(buyer:)).to be_an_instance_of(BuyerMatcher)
    end
  end

  describe '#find_matches' do
    context 'with cancelled purchases' do
      let(:status) { 'cancelled' }

      context 'when buyer buys type of produce > 1' do
        let(:seller) { create(:seller) }
        let(:produce) { create(:produce) }

        context 'when purchases are within 14 days' do
          let(:purchase_traits) do
            {
              status:,
              seller:,
              produce:
            }
          end
          let(:buyer) { buyer_with_purchases(purchase_count: 5, **purchase_traits) }

          it 'returns no matches' do
            expect(described_class.new(buyer:).find_matches).to eq([])
          end
        end

        context 'when purchases are outside of 14 days' do
          let(:purchase_traits) do
            {
              status:,
              seller:,
              produce:
            }
          end
          let(:buyer) do
            buyer_with_purchases(purchase_count: 5, purchases_time_distance: { from: 6.years.ago, to: Time.now },
                                 **purchase_traits)
          end

          it 'returns no matches' do
            expect(described_class.new(buyer:).find_matches).to eq([])
          end
        end
      end
    end

    context 'with complete purchases' do
      let(:status) { 'completed' }
      let(:produce) { create(:produce) }
      let(:seller) { create(:seller) }
      let(:seller2) { create(:seller) }

      context 'when buyer buys type of produce > 1' do
        context 'when purchases are within 14 days' do
          let(:purchase_traits) do
            {
              status:,
              seller:,
              produce:
            }
          end
          let(:buyer) { buyer_with_purchases(purchase_count: 5, **purchase_traits) }

          it 'returns a list of matches' do
            expect(described_class.new(buyer:).find_matches).to eq([{ id: seller.id, name: seller.name }])
          end
        end

        context 'when purchases are outside of 14 days' do
          let(:purchase_traits) do
            {
              status:,
              seller:,
              produce:
            }
          end
          let(:buyer) do
            buyer_with_purchases(purchase_count: 5, purchases_time_distance: { from: 6.years.ago, to: Time.now },
                                 **purchase_traits)
          end

          it 'returns no matches' do
            expect(described_class.new(buyer:).find_matches).to eq([])
          end
        end
      end
    end
  end
end
