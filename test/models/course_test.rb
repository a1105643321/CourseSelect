require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @course = Course.new(name:"知识产权", course_type:"公共必修课", course_time:"周日(5-7)", course_week:"第2-11周", class_room:"教1-101", credit:"20/1.0", teaching_type:"课堂讲授为主", exam_type:"读书报告")
    @update = Course.new(name:"工程伦理")
  end
  
  test "name should be present" do
    @course.name = "     "
    assert_not @course.valid?
  end
  
  test "course_type should be present" do
    @course.course_type = "     "
    assert_not @course.valid?
  end
  
  test "course_time should be present" do
    @course.course_time = "     "
    assert_not @course.valid?
  end
  
  test "course_week should be present" do
    @course.course_week = "     "
    assert_not @course.valid?
  end
  
  test "class_room should be present" do
    @course.class_room = "     "
    assert_not @course.valid?
  end
  
  test "credit should be present" do
    @course.credit = "     "
    assert_not @course.valid?
  end
  
  test "teaching_type should be present" do
    @course.teaching_type = "     "
    assert_not @course.valid?
  end
  
  test "exam_type should be present" do
    @course.exam_type = "     "
    assert_not @course.valid?
  end
  
  
  test "name should not be too long" do
    @course.name = "a" * 51
    assert_not @course.valid?
  end
  
  test "course_type should not be too long" do
    @course.course_type = "a" * 51
    assert_not @course.valid?
  end
  
  test "course_time should not be too long" do
    @course.course_time = "a" * 51
    assert_not @course.valid?
  end
  
  test "course_week should not be too long" do
    @course.course_week = "a" * 51
    assert_not @course.valid?
  end
  
  test "class_room should not be too long" do
    @course.class_room = "a" * 51
    assert_not @course.valid?
  end
  
  test "credit should not be too long" do
    @course.credit = "a" * 51
    assert_not @course.valid?
  end
  
  test "teaching_type should not be too long" do
    @course.teaching_type = "a" * 51
    assert_not @course.valid?
  end
  
  test "exam_type should not be too long" do
    @course.exam_type = "a" * 51
    assert_not @course.valid?
  end
  
end
