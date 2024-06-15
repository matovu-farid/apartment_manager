# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
users = User.create([{email: 'farid@gmail.com', password: 'password'},{email: 'matovu@gmail.com', password: 'password'} ])

blocks = Block.create([{name: 'Block A'},{name: 'Block B', }])

apartments = Apartment.create([{price: 200000, floor: "5th", block: Block.first, name:"firstapartment"}, {price: 200000, floor: "5th", block: Block.first, name:"secondapartment"}])

residents = Resident.create([{name: 'Farid', physicalId: '123456', phonenumber: '0781234567'},{name: 'Matovu', physicalId: '123456', phonenumber: '0781234567'}])

rent_sessions = RentSession.create([{startdate: DateTime.now, paymentDueDate: '2021-12-12', resident: Resident.first, apartment: Apartment.first},{startdate: DateTime.now, paymentDueDate: '2021-12-12', resident: Resident.first, apartment: Apartment.first}])

# block_admins = BlockAdmin.create([{user: User.first, block: Block.first}])

