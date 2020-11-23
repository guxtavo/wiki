#!/usr/bin/ruby
# frozen_string_literal: false

require 'csv'
filename = '/etc/passwd'
CSV.foreach(filename, headers: false, :col_sep => ':') do |row|
  print row[0]
  print ':'
  puts row[5]
end
