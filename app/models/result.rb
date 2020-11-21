class Result
  include Mongoid::Document

  field :text, type: String

  belongs_to :index
end