require 'test_helper'

class ReviewTestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get review_test_index_url
    assert_response :success
  end

end
