require 'rails_helper'


RSpec.describe Wh2find::Indexer do
  context "name index" do
  #   Wh2find::INDEXABLES = [
  #     {
  #       entity_name: 'entity',
  #       entity: TestEntity,
  #       fields_to_index: {
  #         name: {
  #           weight: 1
  #         }
  #       }
  #     }
  #   ]
    describe "#index" do
      context "receiving \"La La Land\"" do
        it "index _l la a_ _l' la' an nd d_" do
          stub_const "Wh2find::INDEXABLES", [
            {
              entity_name: 'entity',
              entity: TestEntity,
              fields_to_index: {
                name: {
                  weight: 1
                }
              }
            }
          ]
          name = "La La Land"
          index_id = BSON::ObjectId("611a91650e024c09406193a2")
          entity = TestEntity.new _id: index_id, name: name
          # entity = instance_double TestEntity, _id: BSON::ObjectId("611a91650e024c09406193a2"), name: "La La Land"
          # allow(entity).to receive(:class).and_return TestEntity
          index_class = class_double(Wh2find::Index).as_stubbed_const
          index = instance_double Wh2find::Index
          expect(index_class).to receive(:find_or_create_by).and_return index
          # wh2find = class_double(Wh2find).as_stubbed_const
          bgrams = ["_l", "la", "a_", "_l'", "la'", "a_'", "_l''", "la''", "an", "nd", "d_"]
          obj = double()
          obj.stub_chain(:Wh2find, :get_bgrams_from).with(name).and_return(bgrams)
          expect(index).to receive(:bgrams=).with(bgrams)
          expect(index).to receive(:weight=).with(1)
          expect(index).to receive(:matching_ids).and_return []
          expect(index).to receive(:matching_ids=).with([entity._id])
          expect(entity).to receive(:indexed_by).and_return []
          allow(index).to receive(:_id).and_return index_id
          expect(entity).to receive(:indexed_by=).with [index_id]
          #TODO: expect datetime
          expect(index).to receive(:save)
          expect(entity).to receive(:mark_as_indexed)
          Wh2find::Indexer.index entity
        end
      end
    end

  end
end
