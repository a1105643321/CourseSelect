class Course < ActiveRecord::Base

  has_many :grades
  has_many :users, through: :grades

  belongs_to :teacher, class_name: "User"

  validates :name, :course_type, :course_time, :course_week,
            :class_room, :credit, :teaching_type, :exam_type, presence: true, length: {maximum: 50}
            
enum course_type: {
  "一级学科核心课" => 0,
}


#课程名称，课程属性，课程时间，课程周数，教室，课时/学分，授课方式，考试方式，
end
