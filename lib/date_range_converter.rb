class DateRangeConverter
  # RE = /(\d{2,}[-,\/]\d{2}[-,\/]\d{2,}).*(\d{2,}[-,\/]\d{2}[-,\/]\d{2,})/
  # RE = /(\d{2,}[-,\/]\d{2}[-,\/]\d{2,})/

  VALID_FORMATS = ["%Y-%m-%d %H:%M %Z",
                   "%Y/%m/%d %H:%M %Z",
                   "%Y/%m/%d %H:%M",
                   "%Y-%m-%d %H:%M",
                   "%Y/%m/%d",
                   "%Y-%m-%d"
  ]

  def self.convert_to_date(datestring)
    VALID_FORMATS.each do |format|
      date = Time.strptime(datestring, format) rescue false
      return date if date
    end
    return false
  end


  # def self.match_regex(datestring)
  #   match = RE.match(datestring)
  #   return match
  # end

  # def self.match_to_range(match)
  #   return Time.parse(match[1])..Time.parse(match[2])
  # end

  def self.build_range(split_start, split_end)
    range_start = convert_to_date(split_start)
    range_end = convert_to_date(split_end)

    return nil if range_start == false || range_end == false

    return range_start..range_end
  end

  def self.split_datestring(datestring)
    datestring.split(" - ")
  end

  def self.split_rangestring(datestring)
    datestring.split("..").inject{ |s,e| Time.parse(s)..Time.parse(e) }
  end

  def self.string_to_daterange(datestring)
    return nil if datestring.class != String
    return nil if datestring.length == 0

    range = split_rangestring(datestring)
    return range if range.class == Range

    split = split_datestring(datestring)
    # split = split.map{|i| match_regex(i)[0]}
    return build_range(split[0], split[1])
  end
end

