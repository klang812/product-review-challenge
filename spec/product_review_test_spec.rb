require './product_review.rb'

describe ProductReviews do
  let(:productReviews) {ProductReviews.new}
  describe 'load_file' do
    it 'loads product review file' do
      expect(productReviews.load_file("sample-input.txt")).to match_array(["G.C., keychain - approve", "J.M., holographic t-shirt - approve", "J.M., basket of kittens - reject", "B.L., holographic t-shirt - approve", "G.C., holographic t-shirt - approve", "B.L., basket of kittens - approve", "J.M., mug - approve", "K.S., mug - reject", "G.C., basket of kittens - reject", "K.L., basket of kittens - approve"])
    end
  end

  describe 'read_file' do
    it 'reads the file' do
      productReviews.read_file("sample-input.txt")
      expect(productReviews.productApproval).to match_array([{"keychain"=>"approve"}, {"holographic t-shirt"=>"approve"}, {"basket of kittens"=>"reject"}, {"holographic t-shirt"=>"approve"}, {"holographic t-shirt"=>"approve"}, {"basket of kittens"=> "approve"}, {"mug"=>"approve"}, {"mug"=>"reject"}, {"basket of kittens"=>"reject"}, {"basket of kittens"=>"approve"}])
    end
  end

  describe 'populate_approve_and_deny_lists' do
    it 'populates the approve and deny lists' do
      productReviews.read_file("sample-input.txt")
      productReviews.populate_approve_and_deny_lists
      expect(productReviews.productApproved).to match_array(["basket of kittens", "basket of kittens", "holographic t-shirt", "holographic t-shirt", "holographic t-shirt", "keychain", "mug"])
      expect(productReviews.productDenied).to match_array(["basket of kittens", "basket of kittens", "mug"])
    end
  end

  describe 'remove_product_from_approval_if_denied' do
    it 'removes product from approval if denied' do
      productReviews.read_file("sample-input.txt")
      productReviews.populate_approve_and_deny_lists
      productReviews.remove_product_from_approval_if_denied
      expect(productReviews.productApproved).to match_array(["holographic t-shirt", "holographic t-shirt", "holographic t-shirt", "keychain"])
      expect(productReviews.productDenied).to match_array(["basket of kittens", "basket of kittens", "mug"])
    end
  end

  describe 'display results' do
    it 'displays results' do
      productReviews.read_file("sample-input.txt")
      productReviews.populate_approve_and_deny_lists
      productReviews.remove_product_from_approval_if_denied
      expect do
        productReviews.display_results
      end.to output("Approved\nholographic t-shirt\nkeychain\n\nDenied\nbasket of kittens\nmug\n").to_stdout
    end
  end
end

