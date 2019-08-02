class Volunteer
  attr_accessor :name, :project_id
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @project_id = attributes.fetch(:project_id)
  end

  def self.all
    results = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    results.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id")
      project_id = volunteer.fetch("project_id")
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(volunteer_to_compare)
    self.name() == volunteer_to_compare.name()
  end

  def self.clear
  DB.exec("DELETE FROM volunteers *;")
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    name = volunteer.fetch("name")
    project_id = volunteer.fetch("project_id")
    id = volunteer.fetch("id")
    Volunteer.new({:name => name, :project_id => project_id, :id => id})
  end

  def update(attributes)
    @name = attributes[:name]
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

  def self.name
    result = DB.exec("SELECT * FROM volunteers WHERE id = #{@id};")
    name = result.first.fetch("name")
    name
  end

  def self.id
    result = DB.exec("SELECT * FROM volunteers WHERE id = #{@id}")
    id = result.first.fetch("id").to_i
  end

  def self.project_id
    result = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@project_id}")
    result.first.fetch("project_id").to_int
  end

  def self.find_by_volunteer(proj_id)
    volunteers = []
    results = DB.exec("SELECT * FROM volunteers WHERE project_id = #{proj_id};")
    results.each() do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id")
      vulunteers.push(Volunteer.new({:name => name, :project_id => proj_id, :id => id }))
    end
    volunteers
  end

end
