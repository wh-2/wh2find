module Wh2find
  module Indexable
    extend ActiveSupport::Concern
    include Mongoid::Document

    included do
      field :indexed_by, type: Set, default: []
      field :index_updated, type: Mongoid::Fields::Boolean
      field :indexed_at, type: DateTime

      def self.get_stats
        self.collection.aggregate(
          [
            {
              '$project': {
                'indexed_by': 1,
                'index_updated': 1,
                'is_indexed': {
                  '$and': [
                    {
                      '$isArray': '$indexed_by'
                    }, {
                      '$size': '$indexed_by'
                    }
                  ]
                }
              }
            }, {
              '$project': {
                'indexed_by': 1,
                'index_updated': 1,
                'is_indexed': 1,
                'index_status': {
                  '$switch': {
                    'branches': [
                      {
                        'case': {
                          '$and': [
                            '$is_indexed', '$index_updated'
                          ]
                        },
                        'then': 2
                      }, {
                        'case': {
                          '$and': [
                            '$is_indexed', {
                            '$not': '$index_updated'
                          }
                          ]
                        },
                        'then': 1
                      }
                    ],
                    'default': 0
                  }
                }
              }
            }, {
              '$bucket': {
                'groupBy': '$index_status',
                'boundaries': [
                  0, 1, 2, 3
                ],
                'default': -1,
                'output': {
                  'count': {
                    '$sum': 1
                  }
                }
              }
            }, {
              '$project': {
                'count': 1,
                'id': '$_id',
                'index_status': {
                  '$arrayElemAt': [
                    [
                      'to_index', 'to_reinddex', 'indexed'
                    ], '$_id'
                  ]
                }
              }
            }
          ]
        )
      end

      def mark_as_indexed
        self.set index_updated: true
      end

      before_update :invalidate_index

      # before_destroy do |document|
      #   puts "BEFORE DESTROY #{document}"
      #   document.indexed_by.map do |index_id|
      #     puts "INDEXED ID #{index_id}"
      #     index = Wh2find::Index.find index_id
      #     puts "INDEX #{index}"
      #     index.detach document
      #   end
      # end
      before_destroy :clean_indexes

      def invalidate_index
        self.index_updated = false
      end

      def clean_indexes
        self.indexed_by.map do |index_id|
          index = Wh2find::Index.find index_id
          index.detach self
        end
      end
    end
  end
end