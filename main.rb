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
  erb :index
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

