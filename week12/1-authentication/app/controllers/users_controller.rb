class UsersController < ApplicationController

	def new 
		@user = User.new
	end

	def create

		@user = User.new(user_params)

		if @user.save 
			session[:@user_id] = @user.id
			redirect_to '/', notice: 'User was successfully created.'
		else
			render :new, status: :unprocessable_entity
		end
	end

	def index
		@users = User.all
	end

private

def user_params
	params.require(:user).permit(:f_name, :l_name, :email, :password, :password_confirmation, :remember_me)
end

end