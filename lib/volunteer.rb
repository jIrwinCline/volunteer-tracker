class Volunteer
  attr_accessor :name, :project_id
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @project_id = attributes.fetch(:project_id)
  end

  def ==(volunteer_to_compare)
    if volunteer_to_compare != nil
      (self.name() == volunteer_to_compare.name()) && (self.project_id() == volunteer_to_compare.project_id())
    else
      false
    end
  end

  def self.all
    results = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    results.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id").to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end


  def self.clear
  DB.exec("DELETE FROM volunteers *;")
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    if volunteer
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      Volunteer.new({:name => name, :project_id => project_id, :id => id})
    else
      nil
    end
  end

  def update(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    DB.exec("UPDATE volunteers SET name = '#{@name}', project_id = #{@project_id} WHERE id = #{@id};")
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

  def project
    Project.find(@project_id)
  end

end
