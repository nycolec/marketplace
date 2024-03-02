# frozen_string_literal: true

class CreatePurchase
  include Interactor::Organizer

  organize Purchases::InitializePurchase, Buyers::FindBuyer, Sellers::FindSeller, Produces::FindProduce,
           Purchases::SetPurchaseAttributes, Purchases::SavePurchase
end
