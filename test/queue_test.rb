require File.expand_path("../helper", __FILE__)

context "Queue" do
  setup do
    itunes_setup
  end

  test "name" do
    assert_equal 'iTunes DJ', Play::Queue.name
  end
end