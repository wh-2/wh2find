namespace :wh2find do
  desc "Index the configured entities"
  task index: :environment do
    # include Wh2find
    to_index_entities = Wh2find::INDEXABLES
    to_index_entities.each do |index_data|
      index_data[:entity].all.each do |entity|
        Wh2find::Indexer.index entity
      end
    end
  end

  task :index_news, [:entity_name, :duration_limit] => [:environment] do |_, args|
    include When2stop
    index_data = Wh2find::INDEXABLES.find entity_name: args[:entity_name]
    entity_class = index_data[:entity]
    iterate do
      entity = entity_class.find indexed_by: []
      if entity
        Wh2find::Indexer.index entity
      end
    end
  end

  task :reindex, [:entity_name, :duration_limit] => [:environment] do |_, args|
    include When2stop
    index_data = Wh2find::INDEXABLES.find entity_name: args[:entity_name]
    entity_class = index_data[:entity]
    iterate do
      entity = entity_class.find index_updated: false
      if entity
        Wh2find::Indexer.index entity
      end
    end
  end
end
