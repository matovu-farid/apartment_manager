# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(
  [{ email: 'farid@gmail.com', password: 'password' }, { email: 'matovu@gmail.com', password: 'password' }]
)

Block.create([{ name: 'Block A' }, { name: 'Block B' }])

Apartment.create(
  [
    { price: 200_000, floor: '5th', block: Block.first, name: 'firstapartment' },
    { price: 200_000, floor: '5th', block: Block.first, name: 'secondapartment' }
  ]
)

Resident.create(
  [
    { name: 'Farid', physicalId: '123456', phonenumber: '0781234567' },
    { name: 'Matovu', physicalId: '123456', phonenumber: '0781234567' }
  ]
)

RentSession.create(
  [
    { paymentDueDate: '2021-12-12', resident: Resident.first, apartment: Apartment.first },
    { paymentDueDate: '2021-12-12', resident: Resident.first, apartment: Apartment.first }
  ]
)

# block_admins = BlockAdmin.create([{user: User.first, block: Block.first}])
