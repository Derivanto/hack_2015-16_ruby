class LecturesController < ApplicationController

def new 
	@lecture = Lecture.new
end

def index
	@lectures = Lecture.all
end

def show
	@lecture = Lecture.find(params[:id])
end

def create
	@lecture = Lecture.new(lecture_params)
	if @lecture.save
		redirect_to lectures_path
	else
		render :new, status: :unprocessable_entity
	end
end

private
	
	def lecture_params
    params.require(:lecture).permit(:name, :body)
  end

end