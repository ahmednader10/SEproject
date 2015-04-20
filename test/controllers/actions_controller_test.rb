require 'test_helper'

class ActionsControllerTest < ActionController::TestCase

	def setup
		@action = actions(:one)
	end

	def teardown
		@action = nil
	end

	test "should get the show all system log" do
		get :indexall
		assert_response :success
	end

	test "should get unhidden system log" do
		get :index
		assert_response :success
	end

	test "should redirect to the unhidden system log" do
		put :hide, id: @action.id
		assert_redirected_to '/syslog'
	end

	test "should redirect to the show all system log" do
		put :unhide, id: @action.id
		assert_redirected_to '/syslogall'
	end

	test "should hide all and redirect to the unhidden system log" do
		put :hideall
		assert_redirected_to '/syslog'
	end

	test "should unhide all and redirect to the unhidden system log" do
		put :unhideall
		assert_redirected_to '/syslog'
	end

end