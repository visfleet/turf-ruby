# frozen_string_literal: true

require "test_helper"

require "turf/helper"

class TurfHelperTest < Minitest::Test
  def test_line_string
    line = Turf.line_string([[5, 10], [20, 40]], name: "test line")
    assert_equal(line[:geometry][:coordinates][0][0], 5)
    assert_equal(line[:geometry][:coordinates][1][0], 20)
    assert_equal(line[:properties][:name], "test line")
    assert_equal(
      Turf.line_string([[5, 10], [20, 40]])[:properties],
      {},
      "no properties case",
    )

    assert_raises(ArgumentError, "error on no coordinates") { Turf.line_string }
    exception = assert_raises(Turf::Error) do
      Turf.line_string([[5, 10]])
    end
    assert_equal(
      exception.message,
      "coordinates must be an array of two or more positions",
    )
    assert_raises(Turf::Error, "coordinates must contain numbers") do
      Turf.line_string([["xyz", 10]])
    end
    assert_raises(Turf::Error, "coordinates must contain numbers") do
      Turf.line_string([[5, "xyz"]])
    end
  end

  def test_point
    pt_array = Turf.point([5, 10], name: "test point")

    assert_equal(pt_array[:geometry][:coordinates][0], 5)
    assert_equal(pt_array[:geometry][:coordinates][1], 10)
    assert_equal(pt_array[:properties][:name], "test point")

    no_props = Turf.point([0, 0])
    assert_equal(no_props[:properties], {}, "no props becomes {}")
  end
end