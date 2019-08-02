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
  erb(:tracker)
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

get('/projects/new') do
  erb(:new_project)
end

post('/projects') do
  name = params[:project_name]
  project = Project.new({:name => name, :id => nil})
  project.save()
  redirect to('/projects')
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  erb(:project)
end



post('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i)
  volunteer = Volunteer.new({:name => params[:volunteer_name], :project_id => @project.id, :id => nil})
  volunteer.save()
  erb(:project)
end
