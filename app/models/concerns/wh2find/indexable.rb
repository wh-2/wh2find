module Wh2find
  module Indexable
    extend ActiveSupport::Concern
    include Mongoid::Document

    included do
      field :indexed_by, type: Set
      field :index_updated, type: Boolean

      before_update :invalidate_index

      before_destroy do |document|
        puts "BEFORE DESTROY #{document}"
        document.indexed_by.map do |index_id|
          puts "INDEXED ID #{index_id}"
          index = Wh2find::Index.find index_id
          puts "INDEX #{index}"
          index.detach document
        end
      end

      def invalidate_index
        self.index_updated = false
      end
    end
  end
end