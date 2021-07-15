puts "What is your name?"
name = gets

puts "What is the product you would like to review?"
product = gets

puts "What is your review of the product? (Approve or Reject)"
review = gets

if review === "Approve" || "approve"
  puts "Thank you! #{product} is approved!"
else
  puts "Thank you! #{product} is denied!"
end
