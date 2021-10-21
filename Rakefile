# frozen_string_literal: true

require 'pg'
require 'rake'

task :setup do
  p 'Creating Databases'

  %w[makers_bnb_development makers_bnb_test].each do |db|
    connection = PG.connect
    begin
      connection.exec("CREATE DATABASE #{db};")
    rescue StandardError => e
      p 'Database with a same name already exists' # Implement overwriting past versions
    else
      connection = PG.connect(dbname: db)
      connection.exec('CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(25) NOT NULL, email_address VARCHAR(255) NOT NULL UNIQUE, password VARCHAR(250));')
      connection.exec('CREATE TABLE spaces (id SERIAL PRIMARY KEY, name VARCHAR(40) NOT NULL, description VARCHAR(255) NOT NULL, available_from DATE NOT NULL, available_to DATE NOT NULL, price INT NOT NULL, url VARCHAR, user_id INTEGER REFERENCES users(id));')
      connection.exec('CREATE TABLE bookings (id SERIAL PRIMARY KEY, start_date DATE NOT NULL, end_date DATE NOT NULL, booking_confirmed BOOLEAN, user_id INTEGER REFERENCES users(id), space_id INTEGER REFERENCES spaces(id), host_id INTEGER REFERENCES users(id));')
      connection.exec('CREATE TABLE dates(date DATE, available BOOLEAN, space_id INT REFERENCES spaces(id));')
    end
  end
end

task :seed do
  p 'Seeding development database'
  ruby './db/seed.rb'
end

task :drop_dbs do
  %w[makers_bnb_development makers_bnb_test].each do |db|
    connection = PG.connect(dbname: db)
    connection.exec("DROP DATABASE #{db};")
  rescue StandardError => e
    p "#{db} doesn't exist, nothing to drop"
  end
end
