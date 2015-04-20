require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
	tests CommentsController

test "should get index comment" do
     get :index ,:forum_id=> 1, :idea_id=> 1
    assert_response :success
    assert_not_nil assigns(:comments)
    assert_routing '/forums/1/ideas/1/comments', {controller: 'comments', action: 'index', forum_id: '1', idea_id: '1'}
  end

  test "should get create comment" do

assert_routing({ method: 'post', path: '/forums/1/ideas/1/comments' }, { controller: "comments", action: "create", forum_id: "1" , idea_id: '1'})
  end

  test "should get new comment" do
  	get :new, :forum_id=> 1, :idea_id=> 1
    assert_response :success
    assert_not_nil assigns(:comments)
    assert_routing '/forums/1/ideas/1/comments/new', {controller: 'comments', action: 'new', forum_id: '1', idea_id: '1'}
  end

  test "should get show comment" do
    assert_routing '/forums/1/ideas/1/comments/1', {controller: 'comments', action: 'show', forum_id: '1', idea_id: '1', id:'1'}
  end

test "should get delete comment" do
   assert_generates 'forums/1/ideas/1/comments/3', {controller: 'comments' , action: 'destroy', id:'3', forum_id:'1', idea_id:'1'}
  end

test "should get report idea" do
assert_generates '/forums/1/ideas/2/comments/2/reportcomment', {controller: 'comments', action: 'reportcomment', forum_id: '1', idea_id: '2', id: '2'}
end

end