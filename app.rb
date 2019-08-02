require('sinatra')
require('sinatra/reloader')
require('./lib/project.rb')
require('./lib/volunteer.rb')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteers_db_test", :password => "ibanez12rylee12345"})

get('/') do
  redirect to('/tracker')
end

get('/tracker') do
  erb(:albums)
end
