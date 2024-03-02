# frozen_string_literal: true

class GetSuggestionsForBuyer
  include Interactor::Organizer

  organize Buyers::FindBuyer, Purchases::FindMatchesForBuyer
end
