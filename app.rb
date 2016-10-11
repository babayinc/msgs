# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'sinatra/reloader'

enable :sessions

class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
end


get '/' do
  @posts = Post.order('created_at DESC')
  @title = 'Welcome.'
  erb :'posts/index'
end

get '/login' do
  erb :'auth/login'
end

get '/signup' do
  erb :'auth/signup'
end

get '/posts/create' do
  @title = 'Create post'
  @post = Post.new
  erb :'posts/create'
end


get '/posts/:id' do
  @post = Post.find(params[:id])
  @title = @post.title
  erb :'posts/view'
end


post '/posts' do
  @post = Post.new(params[:post])
  if @post.save
    redirect "posts/#{@post.id}", :notice => 'OK'
  else
    erb :'posts/create', :error => 'Something went wrong. Try again.'
  end
end

get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  @title = 'Edit Form'
  erb :'posts/edit'
end

put '/posts/:id' do
  @post = Post.find(params[:id])
  @post.update(params[:post])
  redirect "/posts/#{@post.id}"
end



("a".."z").each do |i|
  get "/test/#{i}" do
    erb "#{i}"
  end
end

helpers do
  def title
    if @title
      "#{@title}"
    else
      "Welcome."
    end
  end
end
