class Project
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all

  end

  def save

  end

  def ==(project_to_compare)
    self.name() == project_to_compare.name()
  end

  def self.clear
  DB.exec("DELETE FROM projects *;")
  end

  def self.find(id)

  end

  def update(name)
    @name = name
    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end

  # def volunteers
  #   Volunteer.find_by_volunteer(self.id)
  # end


end
