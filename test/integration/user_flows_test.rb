require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "login and browse site" do
    https!
    get "/"
    assert_response :success
 
    post_via_redirect "login", session: {email: users(:user_with_valid_data).email, password: users(:user_with_valid_data).password}
    assert_equal '/login', path
 
    https!(false)
    get "/forums/"
    assert_response :success
    assert assigns(:forums)
  end
end
