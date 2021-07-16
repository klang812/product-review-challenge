#!/usr/bin/env ruby

# require 'optparse'

# options = {}

# OptionParser.new do |parser|
#   parser.on("-fFILE", "--file=FILE", "The sample-input file") do |value|
#     options[:file] = value
#   end
# end.parse!

file_data = File.read(ARGV[0]).split("\n")

productApproval = []

file_data.each do |entry| 
  # i.e. entry = "G.C., keychain - approve"
  dataEntry = entry.split(" ")
  # dataEntry = ["G.C.,","keychain","-","approve"]
  product = ""
  approval = dataEntry[-1]
  # i.e. approval = "approve"
  i=1
  while i<=(dataEntry.length() -3) do
    product += dataEntry[i] + " "
    i += 1
  end
  productApproval.push(product.strip => approval)
end

productApproved = []
productDenied = []

productApproval.each do |approval|
  if (approval.values[0] === 'approve')
    productApproved.push(approval.keys[0])
  else 
    productDenied.push(approval.keys[0])
    # productApproved.delete(approval.keys[0]) (initial approach - if last element was in approval it would also add to approval list)
  end
end

# if product is not 100% approved it will be rejected (based on requirements)
productDenied.each do |denied|
  # denied = keychain
  if (productApproved.include? denied)
    productApproved.delete(denied)
  end
end

puts "Approved"
puts productApproved.sort.uniq
puts
puts "Denied"
puts productDenied.sort.uniq