class LoginsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			if params[:remember_me]
				session[:expires_at] = Time.current + 7.hours  #3.hours.from_now
			end
			redirect_to '/'
		else
			redirect_to '/login'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/'
	end

end