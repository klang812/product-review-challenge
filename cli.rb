#!/usr/bin/env ruby

require 'optparse'

options = {}

OptionParser.new do |parser|
  parser.on("-fFILE", "--file=FILE", "The sample-input file") do |value|
    options[:file] = value
  end
end.parse!


# file = File.open(options[:file])
# puts file.read 


# file.close


# puts "Hello " + options[:name] + "!"

file_data = File.read(options[:file]).split("\n")

productApproval = []

file_data.each do |entry| 
  dataEntry = entry.split(" ")
  product = ""
  approval = dataEntry[-1]
  # for (i=1; i<=entry.length[-3]; i++) do
  i=1
  while i<=(dataEntry.length() -3) do
    product += dataEntry[i] + " "
    i += 1
  end
  productApproval.push(product.strip => approval)
end
# puts productApproval
# mug => approved
productApproved = []
productDenied = []

productApproval.each do |approval|
  # puts approval.keys[0]
  # puts approval.values[0]
  if (approval.values[0] === 'approve')
    productApproved.push(approval.keys[0])
  else 
    productDenied.push(approval.keys[0])
    productApproved.delete(approval.keys[0])
  end
end
puts "Approved"
puts productApproved.sort.uniq
puts
puts "Denied"
puts productDenied.sort.uniq