require 'rails_helper'
require 'mongoid-rspec'

describe Wh2find::Index do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }
  it { is_expected.to have_field(:entity).of_type(String) }
  it { is_expected.to have_field(:text).of_type(String) }
  it { is_expected.to have_field(:bgrams).of_type(Array) }
  it { is_expected.to have_field(:weight).of_type(Float) }
  it { is_expected.to have_field(:field).of_type(String) }
  it { is_expected.to have_field(:matching_ids).of_type(Set) }

  let(:index) { index = Wh2find::Index.new }

  describe "#detach" do
    context "indexing also other(s) documents" do
      id_indexable = "id_indexable"
      id_indexable_2 = "id_indexable_2"
      index.matching_ids = [id_indexable, id_indexable_2]

      it "must quit the given but not the others" do
        indexed_document = double("Wh2Find::Indexable", {_id: id_indexable})
        index.detach indexed_document
        expect(index.matching_ids).not_to include id_indexable
        expect(index.matching_ids).to include id_indexable_2
      end

    end

    context "indexing only the given document" do
      id_indexable = "id_indexable"
      index.matching_ids = [id_indexable]
      it "must quit the given but not the others" do
        indexed_document = double("Wh2Find::Indexable", {_id: id_indexable})
        index.detach indexed_document
        expect(index.matching_ids).to eq []
      end
    end

    context "not indexing document" do

    end
  end
end