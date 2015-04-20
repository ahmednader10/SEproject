require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
	test "should route to remove idea" do
  	assert_generates 'forums/1/ideas/4', {controller: 'ideas' , action: 'destroy', id:'4', forum_id:'1'}
  end
end
