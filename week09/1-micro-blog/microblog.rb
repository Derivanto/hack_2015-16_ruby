require 'sinatra'

class Post
  attr_reader :title, :text, :tags

  def initialize(title, text)
    @title = title
    @text = text
    @tags = extract_tags(title) + extract_tags(text)
  end

  def extract_tags(str)
    temp = str.split
    temp.map! do |word|
      if word.include? '#' and word.size > 1
        word.chars.each_with_index do |ch, i|
          if ch == '#'
            word = word[i+1..word.length]
            break
          end
        end
        word
      else next
      end
    end
    temp.compact!
  end

end



class Blog
  include Enumerable

  @@default_id = '1'

  def initialize()
    @Posts = {}
  end

  def each(&block)
    @Posts.each(&block)
  end

  def [](id)
    @Posts[id]
  end

  def has_id?(id)
    @Posts.has_key?(id)
  end

  def blank?
    @Posts.empty?
  end

  def add_new_post(id = @@default_id, post)
    @Posts[id] = post
    @@default_id = (@@default_id.to_i + 1).to_s
  end

  def delete_post(id)
    @Posts.delete(id)
  end

end

allPosts = Blog.new
1.upto(7) do |id|
  allPosts.add_new_post(Post.new("Title #{id}", "This is the content\n\t of post #{id}"))
end

allPosts.add_new_post(Post.new("i'm a cat post", "cats are awesome #cats"))
allPosts.add_new_post(Post.new("i'm a #cat post", "cats are awesome"))
allPosts.add_new_post(Post.new("i'm a #dog cat post#pets", "cats are\tawesome\n#cats . # "))

get '/' do
  erb :index, :locals => {:allPosts => allPosts}
end

get "/new" do
  erb :create_new_post
end

post "/new" do
  title = params[:title]
  text = params[:content]
  allPosts.add_new_post(Post.new(title, text))
  redirect "/"
end

get "/search/:tag" do |tag|
  has_tag = false
  erb :search_tag, :locals => {allPosts: allPosts, tag: tag, has_tag: has_tag}
end

get "/:id" do |id|
  if allPosts.has_id?(id)
    erb :post_by_id, :locals => {:allPosts => allPosts, :id => id}
  else erb :missing_post, :locals => {id: id}
  end
end

delete '/:id' do |id|
  allPosts.delete_post(id)
  redirect "/"
end

get "/:id/delete" do |id|
  if allPosts.has_id?(id) 
   erb :delete_post, :locals => {:allPosts => allPosts, :id => id}
  else erb :missing_post, :locals => {id: id}
  end
end

get "/*/*" do
  erb :wrong_url
end