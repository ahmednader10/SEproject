require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
	test "should get destroy" do
    delete :destroy
    assert_response :success
  end
end
