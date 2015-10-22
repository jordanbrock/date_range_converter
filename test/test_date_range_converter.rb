require 'test/unit'
require 'date_range_converter'

class TestDateRangeConverter < Test::Unit::TestCase
  def test_regex
    match = DateRangeConverter.match_regex "2015-12-12"
    assert_not_nil match
    assert_equal "2015-12-12", match[1]
  end

  def test_regex_with_different_separators
    match = DateRangeConverter.match_regex "2015/12/12"
    assert_equal "2015/12/12", match[1]
  end

  def test_regest_with_dd_mm_yyyy
    match = DateRangeConverter.match_regex "19/12/2015"
    assert_not_nil match
  end

  # def test_regex_with_mm_dd_yyyy
  #   match = DateRangeConverter.match_regex "09/23/2015"
  #   assert_equal "09/23/2015", match[1]
  # end

  # def test_convert_to_range
  #   match = DateRangeConverter.match_regex "2015-12-12 - 2015-12-19"
  #   range = DateRangeConverter.match_to_range match

  #   assert_not_nil range
  #   assert_equal Range, range.class
  # end

  def test_string_to_daterange
    range = DateRangeConverter.string_to_daterange "2015-12-12 - 2015-12-19"
    assert_not_nil range
    assert_equal Time.parse("2015-12-12"), range.begin
    assert_equal Time.parse("2015-12-19"), range.end
  end

  def test_string_to_daterange_with_dd_mm_yyyy
    range = DateRangeConverter.string_to_daterange "12/12/2015 - 19/12/2015"
    assert_equal Time.parse("2015-12-12"), range.begin
    assert_equal Time.parse("2015-12-19"), range.end
  end

  # def test_string_to_daterange_with_mm_dd_yyyy
  #   range = DateRangeConverter.string_to_daterange "09/29/2015 - 10/15/2015"
  #   assert_equal Time.parse("2015-09-29"), range.begin
  # end
end
