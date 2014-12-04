require 'csv'
require 'yaml'
require 'json'

class Person
  attr_reader :id, :created_at
  attr_accessor :first_name, :last_name, :email

  def initialize(args = {})
    @id = args[:id]
    @first_name = args[:first_name]
    @last_name = args[:last_name]
    @email = args[:email]
    @created_at = args[:created_at]
  end
end

class PersonParser
  attr_reader :file, :people

  def initialize(file)
    @file = file
    @people = nil
  end

  def people

    return @people if @people

    @people = []

    CSV.foreach(file) do |row|
      row_hash = { id: row[0], first_name: row[1], last_name: row[2], email: row[3],  created_at: row[4] }
      @people << Person.new(row_hash)
    end

    @people  
  end

  def save_as_yaml
    people.to_yaml
  end

  def save_as_json
    people_hasher.to_json
  end

  def people_hasher
    people_hashed = []
    people.each do |person|
      people_hashed << {id: person.id, first_name: person.first_name, last_name: person.last_name, email: person.email, created_at: person.created_at}
    end
    people_hashed
  end

end

parser = PersonParser.new('people.csv')

parser.people
parser.save_as_yaml

json_people = parser.save_as_json

unjson = JSON.parse(json_people)
unjson.to_json

puts "There are #{parser.people.size} people in the file '#{parser.file}'."