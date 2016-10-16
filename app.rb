# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'
# require 'sinatra/flash'
# require 'sinatra/redirect_with_flash'
# require 'sinatra/reloader'
require 'aescrypt'
enable :sessions

class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
  # validates :username, presence: true
end

class User < ActiveRecord::Base
  validates :username, presence: true, length: { minimum: 5 }
  validates :username, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
end

helpers do

  def title
    if @title
      "#{@title}"
    else
      "Welcome."
    end
  end

  def login?
    if session[:username].nil?
      return false
    else
      return true
    end
  end

  def username
    return session[:username]
  end

  def short_url id
    linki = username.to_i(36).to_s + id.to_s
    return linki.to_i.to_s(36)
  end

  def id_from_short_url id
    return id.to_i(36).to_s.gsub(username.to_i(36).to_s, '')
  end

  def get_password
    if login?
      user = User.where(:username => username).first
      return user.password
    end
  end
end

get '/' do
  @posts = Post.where(:username => username)
  now = Time.now
  @posts.each do |post|
    if post.visited
      post.delete
    else
      if post.lifetime
        if post.lifetime > 0 && post.created_at < now - post.lifetime * 21600
          post.delete
        end
      end
    end
  end
  # @posts = Post.order('username DESC')
  @title = 'Welcome.'
  erb :'posts/index'
end

get '/auth/login' do
  erb :'auth/login'
end

post '/login' do
  if (user = User.where(:username => params[:user][:username]).first)
    if user.password == params[:user][:password]
      session[:username] = params[:user][:username]
      redirect '/'
    else
      @error = 'Password incorrect. Try again.'
      erb :'auth/login'
    end
  else
    @error = 'Name incorrect. Try again.'
    erb :'auth/login'
  end
end

get '/auth/signup' do
  @user = User.new
  erb :'auth/signup'
end

get '/auth/logout' do
  session[:username] = nil
  redirect '/'
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    redirect 'auth/ok'
  else
    @error = 'Something went wrong. Try again.'
    erb :'auth/signup'
  end
end

get '/auth/ok' do
  erb :'auth/ok'
end

get '/posts/create' do
  @title = 'Create post'
  @post = Post.new
  erb :'posts/create'
end

get '/posts/:id' do
  @post = Post.find(id_from_short_url params[:id])
  @title = @post.title

  if @post.singlevisit
    @post.update_attribute('visited', true)
  end
  erb :'posts/view'
end

post '/posts' do
  @post = Post.new(params[:post])
  @post.username = session[:uesrname]
  @post.body = AESCrypt.encrypt(@post.body, get_password)
  if @post.save
    redirect "/"
  else
    @error = @post.errors.full_messages.first
        # 'Something went wrong. Try again.'
    erb :'posts/create'
  end
end

get '/posts/:id/edit' do
  @post = Post.find(id_from_short_url params[:id])
  @title = 'Edit Form'
  erb :'posts/edit'
end

put '/posts/:id' do
  @post = Post.find(id_from_short_url params[:id])
  params[:post][:body] = AESCrypt.encrypt(params[:post][:body], get_password)
  @post.update(params[:post])
  redirect "/posts/#{short_url @post.id}"
end



