class Project
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    results = DB.exec("SELECT * FROM projects;")
    projects = []
    results.each do |project|
      name = project.fetch("name")
      id = project.fetch("id")
      projects.push(Project.new({:name => name, :id => id}))
    end
    projects
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(project_to_compare)
    self.name() == project_to_compare.name()
  end

  def self.clear
  DB.exec("DELETE FROM projects *;")
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    if project
      name = project.fetch("name")
      id = project.fetch("id").to_i
      Project.new({:name => name, :id => id})
    else
      nil
    end
  end

  def update(name, id)
    @name = name
    @id = id
    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end

  def self.name
    result = DB.exec("SELECT * FROM projects WHERE id = #{@id};")
    name = result.first.fetch("name")
    name
  end

  def self.id
    result = DB.exec("SELECT * FROM projects WHERE id = #{@id}")
    id = result.first.fetch("id").to_i
  end

  def volunteers
    Volunteer.find_by_volunteer(self.id)
  end


end
