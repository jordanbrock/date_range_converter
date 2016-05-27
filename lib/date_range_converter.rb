class DateRangeConverter
  # RE = /(\d{2,}[-,\/]\d{2}[-,\/]\d{2,}).*(\d{2,}[-,\/]\d{2}[-,\/]\d{2,})/
  RE = /(\d{2,}[-,\/]\d{2}[-,\/]\d{2,})/

  def self.match_regex datestring
    match = RE.match(datestring)
    return match
  end

  def self.match_to_range match
    return Time.parse(match[1])..Time.parse(match[2])
  end

  def self.build_range range_start, range_end
    # return range_start.beginning_of_day..range_end.end_of_day if defined?(Rails)
    return range_start..range_end
  end

  def self.split_datestring datestring
    datestring.split(" - ")
  end

  def self.split_rangestring datestring
    datestring.split("..").inject{ |s,e| Time.parse(s)..Time.parse(e) }
  end

  def self.string_to_daterange datestring
    return nil if datestring.class != String
    return nil if datestring.length == 0
    range = split_rangestring(datestring)
    return range if range.class == Range
    split = split_datestring datestring
    split = split.map{|i| match_regex(i)[0]}
    return build_range(Time.parse(split[0]), Time.parse(split[1]))
  end
end

