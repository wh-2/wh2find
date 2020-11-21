Rails.application.routes.draw do
  Wh2find::INDEXABLES.each do |indexable_entity|
    entity_name = indexable_entity[:entity_name]
    get "#{entity_name}/search", controller: entity_name, action: "search"
  end
end
