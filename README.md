# What is this
Time#parse parsable overtime time format: example '2012/01/01 26:30:00' 

# Install
gem install 'overtime'

# Usage
require 'overtime'
Time.parse("2012/01/01 25:00:00 UTC")
  => 2012-01-02 01:00:00 UTC

