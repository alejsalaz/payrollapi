# frozen_string_literal: true

COMPANIES = [
  'S.A.',
  'S.A.S.',
  'Ltda.',
  'S.C.',
  'S. en C.',
  'S.C.A.',
  'E.U.'
].freeze

ROLES = %w[
  admin
  accountant
  user
].freeze

CLASSES = %w[
  i
  ii
  iii
  iv
  v
].freeze

TYPES = [
  'work or labor',
  'fixed-term',
  'indefinite',
  'apprenticeship',
  'temporary'
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
  company_id: Company.find_by(nit: '9009261473').id,
  role: 'admin'
)

User.create!(
  full_name: 'Cristian Rojas Betancur',
  email: 'cristian@nominapp.com',
  password: '101023',
  company_id: Company.find_by(nit: '9009261473').id,
  role: 'accountant'
)

User.create!(
  full_name: 'Carolina Diaz Gomez',
  email: 'caro@nominapp.com',
  password: '101024',
  company_id: Company.find_by(nit: '9009261473').id,
  role: 'user'
)

14.times do
  User.create!(
    full_name: Faker::Name.unique.name.gsub(/[^[\w áéíúóúÁÉÍÓÚñÑ]+$]/, ''),
    email: Faker::Internet.unique.email,
    password: Faker::Internet.unique.password(min_length: 6),
    company_id: Company.all.sample.id,
    role: ROLES.sample
  )
end

Employee.create!(
  card_id: '11111185369',
  company_id: Company.find_by(nit: '9009261473').id,
  full_name: 'Alejandro Salazar Zapata',
  risk_class: 'v',
  job_title: 'Desarrollador backend',
  base_salary: '750000',
  start_date: '2022/07/18',
  termination_date: '2023/01/17',
  type: 'apprenticeship'
)

14.times do |n|
  Employee.create!(
    card_id: n.odd? ? rand(4_000_000..4_999_999).to_s : rand(1_000_000_000..1_999_999_999).to_s,
    company_id: Company.all.sample.id,
    full_name: Faker::Name.unique.name.gsub(/[^[\w áéíúóúÁÉÍÓÚñÑ]+$]/, ''),
    risk_class: CLASSES.sample,
    job_title: Faker::Job.unique.title,
    base_salary: rand(1_000_000..999_999_999),
    start_date: Time.at(77.years.ago + rand * (1.days.from_now.to_f - 77.years.ago.to_f)),
    termination_date: Time.at(1.days.from_now + 1.month + rand * (77.years.from_now.to_f - 1.days.from_now.to_f)),
    type: TYPES.sample
  )
end
