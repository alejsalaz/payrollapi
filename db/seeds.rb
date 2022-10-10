# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

COMPANIES = [
  'S.A.',
  'S.A.S.',
  'Ltda.',
  'S.C.',
  'S. en C.',
  'S.C.A.',
  'E.U.'
].freeze

Company.create!(
  nit: '9009261473',
  legal_name: 'Grupo Quincena S.A.S.',
  display_name: 'Aleluya'
)

7.times do |n|
  name = Faker::Company.unique.name

  Company.create!(
    nit: rand(9_000_000_000..9_999_999_999).to_s,
    legal_name: "#{name} #{COMPANIES.sample}",
    display_name: n.odd? ? "#{name.split(/\W/).first}app" : nil
  )
end

User.create!(
  full_name: 'Alejandro Salazar Zapata',
  email: 'alejo@nominapp.com',
  password: '101022',
  company_id: Company.first.id
)

14.times do
  User.create!(
    full_name: Faker::Name.unique.name.gsub(/[^[\w áéíúóúÁÉÍÓÚñÑ]+$]/, ''),
    email: Faker::Internet.unique.email,
    password: Faker::Internet.unique.password(min_length: 6),
    company_id: Company.all.sample.id
  )
end
