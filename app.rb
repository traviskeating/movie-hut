require 'sinatra'
require 'uri'
require 'active_record'

db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///myvideos')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

class Video < ActiveRecord::Base
end

set :public_folder, "public"

get '/' do 
  @Videos = Video.order("id DESC")
  erb :index
end

get '/create' do
  erb :create
end

post '/create' do
  video = Video.new(params[:video])
  if video.save
    redirect to "/"
  else
    return "Error!"
  end
end