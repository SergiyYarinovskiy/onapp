# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'default_admin@example.com', password: 'password', password_confirmation: 'password')
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

statuses = []
[  
  Status::DEFAULT_STATUS,
  Status::WAIT_CUSTOMER,
  Status::ON_HOLD,
  Status::CANCELED,
  Status::COMPLETED
].each do |status_name|
  statuses << Status.new(name: status_name)
end
Status.import(statuses)
