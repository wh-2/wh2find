module Wh2find
  module Indexer

    def self.index entity
      index_data = Wh2find::INDEXABLES.find {|index_data| index_data[:entity] == entity.class }
      puts "indexing #{entity}"
      index_data[:fields_to_index].each do |index_field, properties|
        text = entity.read_attribute index_field
        index = Wh2find::Index.find_or_create_by text: text, field: index_field, entity: index_data[:entity_name]
        index.bgrams = Wh2find.get_bgrams_from text
        index.weight = properties[:weight]
        index.matching_ids = index.matching_ids << entity._id
        entity.indexed_by = entity.indexed_by << index._id
        entity.indexed_at = DateTime.now
        index.save!
      end
      entity.index_updated = true
      entity.save!
      puts "Entity indexed"
    end
  end
end