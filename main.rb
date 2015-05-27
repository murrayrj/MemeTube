require "pry"
require "sinatra"
require "sinatra/reloader" if development?
require "pg"

get '/' do
  redirect to ('/videos')
end

get '/videos' do
  sql = "select * from videos"
  @videos = run_sql(sql)
  @featured_video = run_sql(sql).to_a.sample['url']
  erb :index
end

get '/videos/add' do
  erb :add
end

post '/videos' do
  sql = "insert into videos (title, description, url, genre) values ('#{params[:title]}', '#{params[:description]}', '#{params[:url]}', '#{params[:genre]}')"
  run_sql(sql)
  redirect to("/videos/view/#{params[:id]}")
end

private

def run_sql(sql)
  conn = PG.connect(dbname: 'memetube', host: 'localhost')
  begin
    conn.exec(sql)
  ensure
    conn.close
  end
end

def sql_string(value)
  "'#{value.gsub("'","''")}'"
end

