require "rspec/expectations"

RSpec::Matchers.define :be_a_indexable_document do
  match do |actual|
    expect(actual).to include_module Wh2find::Indexable

    # include_examples "indexable", actual
  end
end
