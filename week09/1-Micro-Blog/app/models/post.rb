class Post < ActiveRecord::Base
	validates :name, presence: true
	validates :content, presence: true
end

#rails g scaffold Photo url:string
#rake db:migrate
