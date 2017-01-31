require 'test/unit'
require 'date_range_converter'

class TestDateRangeConverter < Test::Unit::TestCase
  def test_convert_to_date_with_yyyy_mm_dd_hh_mm
    date = DateRangeConverter.convert_to_date("2016-11-11 23:23")
    assert_equal date, Time.parse("2016-11-11 23:23")
    assert date
  end

  def test_convert_to_date_with_yyyy_mm_dd
    date = DateRangeConverter.convert_to_date("2015-12-12")
    assert_equal date, Time.parse("2015-12-12")
  end

  def test_string_to_daterange
    range = DateRangeConverter.string_to_daterange "2015-12-12 - 2015-12-19"
    assert_not_nil range
    assert_equal Time.parse("2015-12-12"), range.begin
    assert_equal Time.parse("2015-12-19"), range.end
  end

  # def test_string_to_daterange_with_dd_mm_yyyy
  #   range = DateRangeConverter.string_to_daterange "12/12/2015 - 19/12/2015"
  #   assert_equal Time.parse("2015-12-12"), range.begin
  #   assert_equal Time.parse("2015-12-19"), range.end
  # end

  def test_string_to_daterange_with_range_to_s
    daterange = "2015-06-01 00:00 AWST..2016-05-31 23:59 AWST"
    range = DateRangeConverter.string_to_daterange daterange
    assert_equal Time.parse("2015-06-01 00:00 AWST"), range.begin
  end

  def test_string_to_daterange_with_times
    daterange = "2015-06-01 03:00 AWST - 2015-06-01 05:00 AWST"
    range = DateRangeConverter.string_to_daterange(daterange)
    assert_equal Time.parse("2015-06-01 03:00 AWST"), range.begin
  end

  # def test_string_to_daterange_with_mm_dd_yyyy
  #   range = DateRangeConverter.string_to_daterange "09/29/2015 - 10/15/2015"
  #   assert_equal Time.parse("2015-09-29"), range.begin
  # end
end
