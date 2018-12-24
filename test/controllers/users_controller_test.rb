require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  
  test "test_create" do
    post :create, :user => {name: "Yuanyating", email: "user1@example.com", password: "password", password_confirmation: "password"}
    assert_redirected_to :root
    assert_equal "新账号注册成功,请登陆", flash[:success]
  end
  
  test "test_create_with_nil" do
    post :create, :user => {name: "", email: "", password: "", password_confirmation: ""}
    assert_equal "账号信息填写有误,请重试", flash[:warning]
  end
  
  test "test_edit" do
    post :edit, :id => 1
    assert_redirected_to :root
  end
 
  test "test_update" do
 #   post :update, :id => 1
 #   assert_response :redirect
  end
    
  test "test_destroy_without_user" do
 #   get :destroy, :id => 1
 #   assert_redirected_to :correct_user, :id => 1
 #   assert_redirected_to :destroy, :id => 1
 #   assert_response :success
 #   assert_equal "用户删除", flash[:success]
  end

 
end