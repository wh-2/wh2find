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

    def detach indexed_document
      document_id = indexed_document._id
      puts "DETACH #{indexed_document}"
      self.matching_ids = self.matching_ids.delete document_id
      self.save!
      puts "REMAINING MATCHING IDS #{self.matching_ids}"
      if self.matching_ids.empty?
        puts "DESTROY"
        self.destroy!
      end
    end
  end
end