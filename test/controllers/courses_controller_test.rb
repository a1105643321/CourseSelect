require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "test_create" do
    post :create
    assert_redirected_to :root  
   # assert_redirected_to :action => "create", :course => {course_code:"13MGB001H-01", name:"新课程", course_type:"公共必修课", teaching_type:"课堂讲授为主", exam_type:"读书报告", credit:"20/1.0", limit_num:500, student_num: 100,  class_room:"教1-101", course_time:"周日(5-7)", course_week:"第2-11周"}
  end
  
  test "test edit" do
    post :edit, :id => 17
    assert_response :redirect
  end
  
  test "test update " do
    post :update, :id => 1
    assert_response :redirect
    #get :flash, :course_name => "知识产权"
    #flash[:success] = "更新成功"
  end
  

  
  test "test open" do
    post :open, :id => 1
    assert_response :redirect
   # flash[:success] = "已经成功开启该课程"
  end
  
  test "test close" do
    post :close, :id => 1
    assert_response :redirect
  end
  
  test "test select" do
    post :select, :id => 1
    assert_response :redirect
  end
  
  test "test quit" do
    post :quit, :id => 1
    assert_response :redirect
  end
  
  test "test index" do
    post :index
    assert_redirected_to :root
  end
  
end
