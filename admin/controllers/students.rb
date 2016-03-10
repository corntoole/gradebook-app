GradebookApp::Admin.controllers :students do
  get :index do
    @title = "Students"
    @students = Student.all
    render 'students/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'student')
    @student = Student.new
    render 'students/new'
  end

  post :create do
    @student = Student.new(params[:student])
    if @student.save
      @title = pat(:create_title, :model => "student #{@student.id}")
      flash[:success] = pat(:create_success, :model => 'Student')
      params[:save_and_continue] ? redirect(url(:students, :index)) : redirect(url(:students, :edit, :id => @student.id))
    else
      @title = pat(:create_title, :model => 'student')
      flash.now[:error] = pat(:create_error, :model => 'student')
      render 'students/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "student #{params[:id]}")
    @student = Student.find(params[:id])
    if @student
      render 'students/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'student', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "student #{params[:id]}")
    @student = Student.find(params[:id])
    if @student
      if @student.update_attributes(params[:student])
        flash[:success] = pat(:update_success, :model => 'Student', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:students, :index)) :
          redirect(url(:students, :edit, :id => @student.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'student')
        render 'students/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'student', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Students"
    student = Student.find(params[:id])
    if student
      if student.destroy
        flash[:success] = pat(:delete_success, :model => 'Student', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'student')
      end
      redirect url(:students, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'student', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Students"
    unless params[:student_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'student')
      redirect(url(:students, :index))
    end
    ids = params[:student_ids].split(',').map(&:strip)
    students = Student.find(ids)
    
    if Student.destroy students
    
      flash[:success] = pat(:destroy_many_success, :model => 'Students', :ids => "#{ids.join(', ')}")
    end
    redirect url(:students, :index)
  end
end
