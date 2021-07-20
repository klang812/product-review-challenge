#!/usr/bin/env ruby

# require 'optparse'

# options = {}

# OptionParser.new do |parser|
#   parser.on("-fFILE", "--file=FILE", "The sample-input file") do |value|
#     options[:file] = value
#   end
# end.parse!

class ProductReviews

  attr_reader :productApproval, :productApproved, :productDenied
  
  def initialize
    @productApproval = []
    @productApproved = []
    @productDenied = []
  end

  def load_file(fileName)
    File.read(fileName).split("\n")
  end

  def read_file(fileName)
    fileData = load_file(fileName)
    fileData.each do |entry| 
      # i.e. entry = "G.C., keychain - approve"
      dataEntry = entry.split(" ")
      # dataEntry = ["G.C.,","keychain","-","approve"]
      product = ""
      approval = dataEntry[-1]
      # i.e. approval = "approve"
      initials = dataEntry[0]
      i=1
      while i<=(dataEntry.length() -3) do
        product += dataEntry[i] + " "
        i += 1
      end
      @productApproval.push(product.strip => [approval, initials])
    end
  end

  def populate_approve_and_deny_lists
    @productApproval.each do |approval|
      if (approval.values[0][0] === 'approve')
        @productApproved.push(approval.keys[0])
      else 
        if (@productDenied.any? {|h| h.has_key?(approval.keys[0])})
          # {"t-shirt" => ["k.l.""]}
          @productDenied[approval.keys[0]].push(approval.values[0][1])
          # {"t-shirt" => ["k.l.","d.b."]}
          # @productDenied.push(approval.keys[0] => [approval.values[0][1]])
        else
          # {}
          @productDenied.push(approval.keys[0] => [approval.values[0][1]])
          # {"mug" => ["g.k."]}
        end
        # {"t-shirt" => ["k.l.","d.b."]}
        # {"mug"} => []}
        # $@productApproved.delete(approval.keys[0]) # (initial approach - if last element was in approval it would also add to approval list)
      end
    end
  end

  def remove_product_from_approval_if_denied
    # if product is not 100% approved it will be rejected (based on requirements)
    @productDenied.each do |denied|
      # denied = keychain
      if (@productApproved.include? denied.keys[0])
        @productApproved.delete(denied.keys[0])
      end
    end
  end

  def display_results
    puts "Approved"
    puts @productApproved.sort.uniq
    puts
    puts "Denied"
    # puts @productDenied.sort.uniq # + {}
    @productDenied.sort.uniq.each do |productDeny|
      puts productDeny.keys[0] + " (" + productDeny.values[0].join(",") + ")" 
    end
  end

  def run_application(fileName)
    read_file(fileName)
    populate_approve_and_deny_lists()
    remove_product_from_approval_if_denied()
    display_results()
  end
end

# product_reviews = ProductReviews.new
# product_reviews.run_application(ARGV[0])
# moved to separate file (worked with no tests)