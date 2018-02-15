require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'pry'

set :database, "sqlite3:development.sqlite3"
set :sessions, true

get '/' do 
	@blogs = Blog.all.last(10).sort_by { |r| r.id }.reverse
	erb :home	
end

post '/create_users' do
	User.create(username: params[:username], password: params[:password])
	redirect '/'
end

get "/users/new" do
	erb :"users/new"
end

get "/users" do
	@users = User.all
	erb :"users/index"
end
	
get '/users/:id' do
	@user = User.find(params[:id])
	@blogs = Blog.all
	erb :'users/show'
end

post '/signin'  do
	@username = params[:username]
	@password = params[:password]
if 
 user = User.where(username: @username, password: @password).first
	session[:user_id] = user.id

	redirect "/users/#{user.id}"
	else
		redirect '/'
	end	
end

get '/users/:id/edit' do
	@user = User.find(params[:id])
	erb :'users/edit'
end


post '/user/:id/update_user' do
	user = User.find(params[:id])
	user.update(username: params[:username], password: params[:password])	
	redirect "/users/#{user.id}"
end

get "/user/:id/delete_user" do
	@user = User.find(params[:id])
	@user.destroy
	redirect '/'
end

post '/logout' do
	session.clear
	redirect "/"
end


post "/user/:id/create_blog" do 
	@user = User.find(params[:id])	
	Blog.create(title: params[:title], content: params[:content], user_id: @user.id)
	redirect '/'
end


get '/blogs/:id' do
	@blog = Blog.find(params[:id])
	@blog.user_id
	#@user = User.find(params[@blog.user_id])
	erb :blog
end





































