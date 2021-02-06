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
    index_data = (Wh2find::INDEXABLES.find entity_name: args[:entity_name]).first
    entity_class = index_data[:entity]
    duration = args[:duration_limit].to_i
    iterate for: duration.minutes do
      # entity = Mongoid::Criteria.new(entity_class).where(:"indexed_by.0".exists => false).first
      entity = entity_class.find_by :"indexed_by.0".exists => false
      if entity
        Wh2find::Indexer.index entity
      end
    end
  end

  task :reindex, [:entity_name, :duration_limit] => [:environment] do |_, args|
    include When2stop
    index_data = (Wh2find::INDEXABLES.find entity_name: args[:entity_name]).first
    entity_class = index_data[:entity]
    duration = args[:duration_limit].to_i
    iterate for: duration.minutes do
      # entity = Mongoid::Criteria.new(entity_class).where(index_updated: false).first
      entity = entity_class.find_by index_updated: false
      if entity
        Wh2find::Indexer.index entity
      end
    end
  end

  task :stats2influx, [:entity_name, :duration_limit] => [:environment] do |_, args|
    include When2stop
    entity_name = args[:entity_name]
    duration = args[:duration_limit].to_i
    index_data = (Wh2find::INDEXABLES.find entity_name: entity_name).first
    entity_class = index_data[:entity]
    iterate for: duration.minutes do
      stats = entity_class.get_stats
      values = Hash[stats.collect { |item| [item[:index_status], item[:count]] }]
      InfluxDB::Rails.client.write_point "#{entity_name}_indexes", tags: {}, values: values
    end
  end
end
