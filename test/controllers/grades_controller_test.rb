require 'test_helper'

class GradesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "test update with update attributes" do
    post :update, :id => 1
    assert_response :redirect
  end
  
  test "test index" do
    post :index, :course_id => "13MGB001H-02"
    assert_response :redirect
  end

end