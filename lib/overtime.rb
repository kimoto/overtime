require "overtime/version"
require 'date'
require 'time'

class Time
  class << Time
    CONST_DAY_HOURS=24
    def parse(str, now=self.now)
      comp = !block_given?
      d = Date._parse(str)
      if !d[:year] && !d[:mon] && !d[:mday] && !d[:hour] && !d[:min] && !d[:sec] && !d[:sec_fraction]
        raise ArgumentError, "no time information in #{date.inspect}"
      end

      year = d[:year]
      year = yield(year) if year && !comp

      if d[:hour]
        (add_day, mod_hour) = (d[:hour]).divmod(CONST_DAY_HOURS)
      else
        (add_day, mod_hour) = [0, nil]
      end

      make_time(year, d[:mon], d[:mday], mod_hour, d[:min], d[:sec], d[:sec_fraction], d[:zone], now) + (add_day * 24 * 60 * 60)
    end
  end
end

module Overtime
end

if $0 == __FILE__
  require 'test/unit'

  class TC_BSTTime < Test::Unit::TestCase
    def setup
    end

    def test_time_bst_parse
      assert_bst_time_pairs [
        ["2009/01/01 10:00:00", "2009/01/01 10:00:00"],
        ["2009/01/01 11:00:00", "2009/01/01 11:00:00"],

        ["2009/01/01 23:59:59", "2009/01/01 23:59:59"],
        ["2009/01/01 24:00:00", "2009/01/02 00:00:00"],
        ["2009/01/01 24:00:01", "2009/01/02 00:00:01"],

        ["2009/01/01 47:59:59", "2009/01/02 23:59:59"],
        ["2009/01/01 48:00:00", "2009/01/03 00:00:00"],
        ["2009/01/01 48:00:01", "2009/01/03 00:00:01"],

        ["2009/01/01", "2009/01/01 00:00:00"],
        ["2009/01", "2009/01/01 00:00:00"],
        ["2009-01-01 01:02:03", "2009/01/01 01:02:03"],

        ["3000/01/01 48:00:01", "3000/01/03 00:00:01"],

        ["2000/12/31 23:59:59", "2000/12/31 23:59:59"],
        ["2000/12/31 24:00:00", "2001/01/01 00:00:00"],

        ["1900/01/01 00:00:00", "1900/01/01 00:00:00"],
        ["0001/01/01 00:00:00", "0001/01/01 00:00:00"],
      ]
    end

    def assert_bst_time_pairs(pairs_list)
      pairs_list.each{ |pairs|
        assert_bst_time(pairs.last, pairs.first)
      }
    end

    def assert_bst_time(true_time, bst_time)
      assert_time true_time, Time.parse(bst_time)
    end

    def assert_time(true_time, time)
      assert_equal(true_time, time.strftime("%Y/%m/%d %H:%M:%S"))
    end
  end
end
