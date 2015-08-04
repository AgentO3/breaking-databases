# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

file = File.open("#{File.dirname(__FILE__)}/data/users.csv","r")
CSV.foreach(file, headers: true) do |row|
  User.create!(row.to_hash)
end

file = File.open("#{File.dirname(__FILE__)}/data/prescriptions.csv","r")
CSV.foreach(file, headers: true) do |row|
  GoodPrescription.create!(row.to_hash)
end

file = File.open("#{File.dirname(__FILE__)}/data/prescriptions.csv","r")
CSV.foreach(file, headers: true) do |row|
  BadPrescription.create!(row.to_hash)
end

file = File.open("#{File.dirname(__FILE__)}/data/emails.csv","r")
CSV.foreach(file, headers: true) do |row|
  Email.create!(row.to_hash)
end
