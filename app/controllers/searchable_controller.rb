class SearchableController < ApplicationController
  def search
    entity_type = params[:controller]
    pattern = params[:q]
    pattern_bgrams = Wh2find.get_bgrams_from pattern
    match_entity = {'$match': {entity: entity_type}}
    project = {
        '$project' => {
            _id: 1,
            matching_ids: 1,
            bgrams: 1,
            score: {
                "$divide": [
                    {
                        "$multiply": [2, {
                            "$size": {
                                "$setIntersection": ["$bgrams", pattern_bgrams]
                            }
                        }
                        ]
                    },
                    {
                        "$sum": [
                            {"$size": "$bgrams"},
                            pattern_bgrams.size

                        ]
                    }
                ]
            }
        }
    }
    sort_by_score = {
        '$sort' => {
            score: -1
        }
    }
    unwind_by_matching_ids = {
        '$unwind' => "$matching_ids"
    }
    limit_results = {
        "$limit" => 10
    }
    matching_indexes = Wh2find::Index.collection.aggregate([
                                                               match_entity,
                                                               project,
                                                               sort_by_score,
                                                               unwind_by_matching_ids,
                                                               limit_results

                                                           ])
    indexable_entity_hash = Wh2find::INDEXABLES.bsearch { |x| x[:entity_name] == entity_type }
    searchable_entity = indexable_entity_hash[:entity]
    found_entities = matching_indexes.as_json.map {|result| searchable_entity.find get_entity_id_from result
    }
    @response = found_entities.as_json
  end

  def get_entity_id_from result
    result["matching_ids"].first.last
  end
end