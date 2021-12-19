
require 'rails_helper'
require 'mongoid-rspec'
require 'wh2find/rspec'

include Mongoid::Matchers
include Wh2find::Matchers


RSpec.describe TestEntity, type: :model do
  # it { is_expected.to be_mongoid_document }
  it { is_expected.to be_a_indexable_document }
  # it { is_expected.to have_callback_for(:update).triggering(:before).with_function(:invalidate_index) }
  #
  #
  # describe "#invalidate_index" do
  #   context "even when index is updated" do
  #     model = TestEntity.new
  #     model.index_updated = true
  #
  #     it "must set index_updated false" do
  #       model.invalidate_index
  #       expect(model.index_updated).to be_falsey
  #     end
  #   end
  # end
  #
  # describe "#mark_as_index" do
  #   model = TestEntity.new
  #   it "must set index_updated true without execute callbacks" do
  #     expect_any_instance_of(TestEntity).to receive(:set).with index_updated: true
  #     model.mark_as_indexed
  #   end
  # end



  # include_examples "indexable", TestEntity

end
