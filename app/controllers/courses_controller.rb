class CoursesController < ApplicationController

  before_action :student_logged_in, only: [:select, :quit, :list, :statistic]
  before_action :teacher_logged_in, only: [:new, :create, :edit, :destroy, :update, :open, :close]#add open by qiao
  before_action :logged_in, only: :index

  #-------------------------for teachers----------------------

  def new
    @course=Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      current_user.teaching_courses<<@course
      redirect_to courses_path, flash: {success: "新课程申请成功"}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'new'
    end
  end

  def edit
    @course=Course.find_by_id(params[:id])
  end

  def update
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(course_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to courses_path, flash: flash
  end

  def open
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: true)
    redirect_to courses_path, flash: {:success => "已经成功开启该课程:#{ @course.name}"}
  end

  def close
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: false)
    redirect_to courses_path, flash: {:success => "已经成功关闭该课程:#{ @course.name}"}
  end

  def destroy
    @course=Course.find_by_id(params[:id])
    current_user.teaching_courses.delete(@course)
    @course.destroy
    flash={:success => "成功删除课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end

  #-------------------------for students----------------------
  def statistic
    @course=current_user.courses.paginate(page: params[:page], per_page: 10)
    @grade = current_user.grades.paginate(page: params[:page], per_page: 10)
  end
  
  def timetable
    @course=current_user.courses.paginate(page: params[:page], per_page: 10)
  end

  def list
    #-------QiaoCode--------
    @courses = Course.where(:open=>true).paginate(page: params[:page], per_page: 10)
    @course = @courses-current_user.courses
    tmp=[]
    @course.each do |course|
      if course.open==true
        tmp << course
      end
    end
    @course=tmp
  end

  def select
    @courses=current_user.courses.paginate(page: params[:page], per_page: 10)
    @course = Course.find_by_id(params[:id])
    # @course = Course.find(:all, :select => 'id')
    tmp = 0
    @courses.each do |course|
      if (course == @course)
        tmp = 1
        flash={:warning => "您已选过该课程: #{@course.name}"}
        return redirect_to list_courses_path, flash: flash
      end
      
      if ((course.course_time[0..1] == @course.course_time[0..1]) && ((@course.course_time[3] >= course.course_time[3])&&(@course.course_time[3] <= course.course_time[5]) || (@course.course_time[5] >= course.course_time[3])&&(@course.course_time[5] <= course.course_time[5])))
        tmp = 1
        flash={:warning => "与已选课程：#{course.name}   时间冲突:)"}
        return redirect_to list_courses_path, flash: flash
      end
      
    end
    
        if (@course.limit_num != '' && (@course.limit_num == @course.student_num))
          tmp = 1
          flash={:warning => "#{@course.name}课程人数已达上限:)"}
          return redirect_to list_courses_path, flash: flash
        end
    
      if (tmp == 0)
        current_user.courses<<@course
        tmp2 = @course.student_num + 1
        @course.update_attributes(:student_num => tmp2)

        flash={:suceess => "成功选择课程: #{@course.name}"}
        return redirect_to (courses_path),  flash: flash
      end
  end

  def quit
    @course=Course.find_by_id(params[:id])
    current_user.courses.delete(@course)
    if @course.student_num > 0
      tmp3 = @course.student_num - 1
      @course.update_attributes(:student_num => tmp3)
    end   
    flash={:success => "成功退选课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end


  #-------------------------for both teachers and students----------------------

  def index
    @course=current_user.teaching_courses.paginate(page: params[:page], per_page: 10) if teacher_logged_in?
    @course=current_user.courses.paginate(page: params[:page], per_page: 10) if student_logged_in?
  end


  private

  # Confirms a student logged-in user.
  def student_logged_in
    unless student_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a teacher logged-in user.
  def teacher_logged_in
    unless teacher_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a  logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def course_params
    params.require(:course).permit(:course_code, :name, :course_type, :teaching_type, :exam_type,
                                   :credit, :limit_num, :class_room, :course_time, :course_week)
  end


end
