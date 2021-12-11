require 'rails_helper'

Rails.application.load_tasks

include When2stop

describe :wh2find do
  describe :log_stats do
    # TODO: stub iterate and finish test
    # it 'should log stats' do
    #   task = Rake::Task['wh2find:log_stats']
    #   entity_name = TestEntity.class
    #   duration = "1"
    #
    #   stub_const "Wh2find::INDEXABLES", [
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
    #
    #   expect(task).stub_chain(:iterate) do |dur, &block|
    #     byebug
    #     expect(dur).to eq(duration.minutes)
    #
    #     expect(TestEntity).to receive(:get_stats).and_return(
    #       [
    #         {
    #           _id: 0,
    #           count: 10,
    #           index_status: 'to_index'
    #         },
    #         {
    #           _id: 1,
    #           count: 5,
    #           index_status: 'to_reindex'
    #         },
    #         {
    #           _id: 2,
    #           count: 1054,
    #           index_status: 'indexed'
    #         },
    #       ]
    #     )
    #     new_relic_agent = double('NewRelic::Agent').as_stubbed_const
    #     expect(new_relic_agent).to receive(:record_metric).with("Wh2find/#{entity_name}/to_index", 10)
    #     expect(new_relic_agent).to receive(:record_metric).with("Wh2find/#{entity_name}/to_reindex", 5)
    #     expect(new_relic_agent).to receive(:record_metric).with("Wh2find/#{entity_name}/indexed", 1054)
    #     block.call()
    #   end
    #
    #   task.invoke(entity_name, duration)
    # end

  end
end