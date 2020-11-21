class SearchableController < ApplicationController
  def search
    entity_type = params[:controller]
    pattern = params[:q]
    pattern_bgrams = Wh2find.get_bgrams_from pattern
    matching_indexes = Wh2find::Index
                           .where(entity: entity_type)
                           .limit(10)
    indexable_entity_hash = Wh2find::INDEXABLES.bsearch { |x| x[:entity_name] == entity_type}
    searchable_entity = indexable_entity_hash[:entity]
    found_entities = []
    matching_indexes.each do |index|
      found_entities += index.matching_ids.map do |entity_id|
        entity_id = entity_id.to_s
        searchable_entity.find entity_id
      end
    end
    @response = found_entities.as_json
  end
end