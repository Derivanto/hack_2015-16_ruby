class SolutionsController < ApplicationController
	before_action :set_task

	def index
		@solutions = @task.solutions
	end

	def new
		@solution = Solution.new
	end

	def create
		@solution = @task.solutions.build(solution_params)

		if @solution.save
			redirect_to lecture_task_solutions_path(params[:lecture_id])
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
		@solution = @task.solutions.find(params[:id])
		render json: @solution
	end

	def edit
		@solution = @task.solutions.find(params[:id])
	end

	def update
		@solution = @task.solutions.find(params[:id])
		if @solution.update(solution_params)
			redirect_to lecture_task_solutions_path(params[:task_id])
		else
			render :new, status: :unprocessable_entity
		end
	end

	private

		def solution_params
    	params.require(:solution).permit(:body, :task_id)
  	end

		def set_task
			@lecture = Lecture.find(params[:lecture_id])
			@task = @lecture.tasks.find(params[:task_id])
		end

end