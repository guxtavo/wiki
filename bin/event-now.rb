#!/usr/bin/ruby
# frozen_string_literal: false

require 'csv'
filename = '/dev/shm/calcurse-a'

if File.file?(filename)
  CSV.foreach(filename, headers: false, :col_sep => ';') do |row|
    event_start = row[0]
    event_stop = row[1]
    event_message = row[2]

    start_hour = event_start.split(':')[0]
    start_min = event_start.split(':')[1]

    stop_hour = event_stop.split(':')[0]
    stop_min = event_stop.split(':')[1]

    now = Time.now
    # puts "now: #{now}"
    # you need to convert now to UTC without shifting the time.
    n_now = Time.gm(now.year, now.month, now.day, now.hour, now.min)
    # puts "now: #{n_now}"
    start = Time.gm(now.year, now.month, now.day, start_hour, start_min)
    # puts "start: #{start}"
    stop = Time.gm(now.year, now.month, now.day, stop_hour, stop_min)
    # puts "stop: #{stop}"

    if Range.new(start, stop).cover? n_now
      puts "#{event_message}"
    end
  end
else
  exit 0
end
