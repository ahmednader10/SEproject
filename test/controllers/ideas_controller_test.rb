require 'test_helper'

class IdeasControllerTest < ActionController::TestCase

	tests IdeasController
# tests destroy action
    test "should route to remove idea" do
      assert_generates 'forums/1/ideas/4', {controller: 'ideas' , action: 'destroy', id:'4', forum_id:'1'}
    end

#tests index action
  test "should get index idea" do
     get :index ,:forum_id=> 1
    assert_response :success
    assert_not_nil assigns(:ideas)
    assert_routing '/forums/1/ideas', {controller: 'ideas', action: 'index', forum_id: '1'}
  end

#test create action
  test "should get create idea" do
  assert_routing({ method: 'post', path: '/forums/1/ideas' }, { controller: "ideas", action: "create", forum_id: "1" })
  end

#tests new action
  test "should get new idea" do
  	get :new, :forum_id=> 1
    assert_response :success
    assert_not_nil assigns(:idea)
    assert_routing '/forums/1/ideas/new', {controller: 'ideas', action: 'new', forum_id: '1'}
  end


  test "should get destroy idea" do
    @forum = forums(:forum_one)
    delete(:destroy, {'id' => "1", 'forum_id' => @forum.id})
    assert_not_nil assigns(:idea)
    assert_not_nil assigns(:forum)
    assert_redirected_to forum_path(@forum)
  end


#tests show action
  test "should get show idea" do
    assert_routing '/forums/1/ideas/1', {controller: 'ideas', action: 'show', forum_id: '1', id: '1'}
  end
#tests like action
test "should get like idea" do
assert_generates '/forums/1/ideas/2/like', {controller: 'ideas', action: 'like', forum_id: '1', id: '2'}
end

#tests report action
 test "should get report idea" do
  assert_generates '/forums/1/ideas/3/report', {controller: 'ideas', action: 'report', forum_id: '1', id: '3'}
 end

	test "should remove idea" do
  	assert_generates 'forums/1/ideas/4', {controller: 'ideas' , action: 'destroy', id:'4', forum_id:'1'}
  end
end
