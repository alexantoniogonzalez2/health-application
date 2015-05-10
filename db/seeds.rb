# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

if ENV["prueba"]
	Dir[File.join(Rails.root, 'db', 'seeds_prueba', '*.rb')].sort.each { |seed| load seed }
	Rake::Task['agendamiento:crear_agendamientos'].invoke
end 

puts 'Fin Seed'