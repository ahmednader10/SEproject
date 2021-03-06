require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
	tests CommentsController

#creates every attribute before each test
  def setup
    @idea = ideas(:complete_idea)
    @forum = forums(:forum_one)
    @comment = comments(:complete_comment)
  end
#destroys each attribute after every test
   def teardown
    @idea = nil
    @forum = nil
    @comment = nil
  end
# tests index action
test "should get index comment" do
     get :index ,:forum_id=> @idea.forum_id, :idea_id=> @idea.id
    assert_response :success
    assert_not_nil assigns(:comments)
    assert_routing '/forums/1/ideas/1/comments', {controller: 'comments', action: 'index', forum_id: '1', idea_id: '1'}
  end
# tests create action
  test "should get create comment" do
assert_routing({ method: 'post', path: '/forums/1/ideas/1/comments' }, { controller: "comments", action: "create", forum_id: "1" , idea_id: '1'})
  end
# tests new action
  test "should get new comment" do
  	get :new, :forum_id=> @idea.forum_id, :idea_id=> @idea.id
    assert_response :success
    assert_routing '/forums/1/ideas/1/comments/new', {controller: 'comments', action: 'new', forum_id: '1', idea_id: '1'}
  end
# tests destroy action
test "should get delete comment" do
   assert_generates 'forums/1/ideas/1/comments/3', {controller: 'comments' , action: 'destroy', id:'3', forum_id:'1', idea_id:'1'}
  end
# tests reportcomment action
test "should get report comment" do
assert_generates '/forums/1/ideas/2/comments/2/reportcomment', {controller: 'comments', action: 'reportcomment', forum_id: '1', idea_id: '2', id: '2'}
end

end