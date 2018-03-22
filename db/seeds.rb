# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

folders = [
	{ name: 'Active Request', position: 1 }, 
	{ name: 'Closed Request', position: 2 }, 
	{ name: 'Archived Request', position: 3 },
	{ name: 'Undergoing Registration', position: 4}
	]

folders.each do |folder|
	unless Folder.where(name: folder[:name]).exists?
		Folder.create(folder)
		puts "Created #{folder[:name]} folder successfully..."
	else
		puts "#{folder[:name]} folder already exists..."
	end
end

categories = [
	{ name: 'Hardware' },
	{ name: 'Software' },
	{ name: 'CPU', parent_id: 1 },
	{ name: 'Main Memory', parent_id: 1 },
	{ name: 'Peripherals', parent_id: 1 },
	{ name: 'System Software', parent_id: 2 },
	{ name: 'Application Software', parent_id: 2 }
]

categories.each do |category|
	unless Category.where(name: category[:name]).exists?
		Category.create(category)
		puts "Created #{category[:name]} category successfully..."
	else
		puts "#{category[:name]} category already exists..."
	end
end