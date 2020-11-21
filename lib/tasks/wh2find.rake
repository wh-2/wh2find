namespace :wh2find do
  desc "Index the configured entities"
  task index: :environment do
    # include Wh2find
    to_index_entities = Wh2find::INDEXABLES
    to_index_entities.each do |index_data|
      index_data[:entity].all.each do |entity|
        puts "indexing #{entity}"
        index_data[:fields_to_index].each do |index_field, properties|
          text = entity.read_attribute index_field
          index = Wh2find::Index.find_or_create_by text: text, field: index_field, entity: index_data[:entity_name]
          index.bgrams = Wh2find.get_bgrams_from text
          index.weight = properties[:weight]
          index.matching_ids = index.matching_ids << entity._id.to_s
          index.save
        end
        puts "Entity indexed"
      end
    end
  end
end
