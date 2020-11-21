module Wh2find
  class Index
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in collection: 'wh2find-indexes'

    field :entity, type: String
    field :text, type: String
    field :bgrams, type: Array
    field :weight, type: Float
    field :field, type: String
    field :matching_ids, type: Set
  end
end