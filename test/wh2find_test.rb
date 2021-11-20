require 'test_helper'

class Wh2find::Test < ActiveSupport::TestCase
  test "get_bgram_with_duplicated_pairs" do
    assert_equal (Wh2find::get_bgrams_from 'lalaland'), ['_l', 'la', 'al', 'la\'', 'al\'', 'la\'\'', 'an', 'nd', 'd_']
  end

  test "create_test_entity" do
    ent = Wh2find::DemoEntity.new
    assert !ent.index_updated
  end


end
