#!/usr/bin/ruby
# frozen_string_literal: false

require 'open3'
current_users = '/home/gfigueira/current_users'
user_changes = '/home/gfigueira/user_changes'
md5sum = '/home/gfigueira/usernames.rb | md5sum'

output = Open3.popen3(md5sum) \
  { |_stdin, stdout, _stderr, _wait_thr| stdout.read }

if File.exist?(current_users)
  previous = File.read(current_users)
  if output != previous
    time = Time.now
    changes = "#{time.inspect} changes ocurred"
    File.open(user_changes, 'a') { |file| file.puts changes.to_s }
    File.open(current_users, 'w') { |file| file.write(output) }
  end
else
  File.open(current_users, 'w') { |file| file.write(output) }
end
