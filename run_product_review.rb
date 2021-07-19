require './product_review.rb'

product_reviews = ProductReviews.new
product_reviews.run_application(ARGV[0])
