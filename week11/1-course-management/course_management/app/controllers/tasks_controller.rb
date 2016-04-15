class TasksController < ApplicationController
	before_action :set_lecture, only: [:index, :create, :new, :edit, :update, :show]

	def index
		@tasks = @lecture.tasks
		#@lecture = Lecture.find(params[:lecture:id])
		#@task = @lecture.tasks
	end

	def new
		@task = Task.new
	end

	def show
		@task = @lecture.tasks.find(params[:id])
		render json: @task
	end

	def create
		#@lecture = Lecture.find(params[:lecture:id])
		@task = @lecture.tasks.build(task_params)

		#@task = Task.new(task_params)
		#@task.lecture_id = params[:lecture:id]

		if @task.save
			redirect_to lecture_tasks_path(params[:lecture_id])
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
		@task = @lecture.tasks.find(params[:id])
	end

	def update
		@task = @lecture.tasks.find(params[:id])
		if @task.update(task_params)
			redirect_to lecture_tasks_path(params[:lecture_id])
		else
			render :new, status: :unprocessable_entity
		end
	end

	private

		def task_params
    	params.require(:task).permit(:name, :description, :lecture_id)
  	end

		def set_lecture
			@lecture = Lecture.find(params[:lecture_id])
		end
end