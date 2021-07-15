#!/usr/bin/env ruby

require 'optparse'

options = {}

OptionParser.new do |parser|
  parser.on("-n", "--name", "The name of the reviewer") do |value|
    options[:name] = value
  end
end.parse!

puts "Hello " + options[:name] + "!"

