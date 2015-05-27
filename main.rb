require "pry"
require "sinatra"
require "sinatra/reloader" if development?
require "pg"

get '/' do
  redirect to ('/videos')
end

get '/videos' do
  sql = "select * from videos"
  
  @videos = @db.exec(sql)
  @random_video = run_sql(random_sql).to_a.sample
  erb :index
end

sql = "insert into videos (title, description, url, genre) values ('#{params[:title]}', '#{params[:description]}', '#{params[:url]}', '#{params[:genre]}')"

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

