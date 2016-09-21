class Agency < ApplicationRecord
  include AlgoliaSearch

  algoliasearch do
    attribute :name, :address, :mail, :phone
  end
end
