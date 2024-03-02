# frozen_string_literal: true

class GetSuggestionsForSeller
  include Interactor::Organizer

  organize Sellers::FindSeller, Purchases::FindMatchesForSeller
end
