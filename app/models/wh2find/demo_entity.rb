module Wh2find
  class DemoEntity
    include Mongoid::Document
    include Wh2find::Indexable

    field :name, type: String
  end
end