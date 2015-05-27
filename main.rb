require "pry"
require "sinatra"
require "sinatra/reloader"
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

get '/videos/view/:id' do
  sql = "select * from videos where id = #{params[:id]}"
  @video = run_sql(sql).first
  erb :view
end

get '/videos/genres' do
  sql = "select genre from videos group by genre order by genre"
  @genres = run_sql(sql)
  erb :genres
end

get '/videos/:genre' do
  binding.pry
  sql = "select * from videos where genre = #{params[:genre]}"
  @videos_by_genre= run_sql(sql)
  erb :genre
end

get '/videos/:id/edit' do
  sql = "select * from videos where id = #{params[:id]}"
  @video = run_sql(sql).first
  erb :edit
end

post '/videos/:id/' do
  sql = "update videos set title = '#{params[:title]}', description = '#{params[:description]}', url = '#{params[:url]}', genre = '#{params[:genre]}' where id = #{params[:id]}"
  run_sql(sql)
  redirect to("/videos/#{params[:id]}")
end

get '/videos/:id/delete' do
  sql = "DELETE FROM videos WHERE id = #{params[:id]}"
  run_sql(sql)
  redirect to("/videos")
end

private

def run_sql(sql)
  conn = PG.connect(dbname: 'memetube', host: 'localhost')
  begin
    result = conn.exec(sql)
  ensure
    conn.close
  end
  result
end

