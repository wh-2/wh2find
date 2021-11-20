require 'rails_helper'
require 'mongoid-rspec'

include Mongoid::Matchers

shared_examples_for 'indexable' do |described_class|
  let(:model) { described_class.new }

  it { is_expected.to be_mongoid_document }
  it { is_expected.to include_module Wh2find::Indexable }
  it { is_expected.to have_field }
  it { is_expected.to have_callback_for(:update).triggering(:before).with_function(:invalidate_index) }
  it { is_expected.to have_callback_for(:destroy).triggering(:before).with_function(:clean_indexes) }


  describe "#invalidate_index" do
    context "even when index is updated" do

      it "must set index_updated false" do
        model.index_updated = true
        model.invalidate_index
        expect(model.index_updated).to be_falsey
      end
    end
  end

  describe "#mark_as_index" do
    it "must set index_updated true without execute callbacks" do
      expect_any_instance_of(described_class).to receive(:set).with index_updated: true
      model.mark_as_indexed
    end
  end

  describe "#clean_indexes" do
    context "having indexes" do

      it "must detach indexes" do
        index_1_id = "index1id"
        index_2_id = "index2id"
        index_classname = "Wh2find::Index"
        index = class_double(index_classname).as_stubbed_const
        index_1 = instance_double(index_classname)
        index_2 = instance_double(index_classname)
        allow(index).to receive(:find).with(index_1_id) { index_1 }
        allow(index).to receive(:find).with(index_2_id) { index_2 }
        expect(index_1).to receive(:detach).with model
        expect(index_2).to receive(:detach).with model
        model.indexed_by = [index_1_id, index_2_id]
        model.clean_indexes
      end
    end
  end
end

class DummyIndexable
  include Wh2find::Indexable
end

describe DummyIndexable, type: :model do

  include_examples "indexable", DummyIndexable

end
