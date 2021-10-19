# frozen_string_literal: true

require_relative 'database_connection'
require 'pg'
require 'bcrypt'

class User
  include BCrypt

  attr_reader :id, :email_address, :name

  def initialize(id:, email_address:, name:)
    @name = name
    @id = id
    @email_address = email_address
  end

  def self.create(email_address:, name:, password:)
    encrypted_password = BCrypt::Password.create(password)

    result = DatabaseConnection.query(
      'INSERT INTO users (email_address, name, password) VALUES($1, $2, $3) RETURNING id, email_address, name;', [
        email_address, name, encrypted_password
      ]
    )

    User.new(id: result[0]['id'], email_address: result[0]['email_address'], name: result[0]['name'])
  end

  def self.authenticate(email_address:, password:)
    result = DatabaseConnection.query('SELECT * FROM users WHERE email_address = $1', [email_address])

    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password

    User.new(id: result[0]['id'], email_address: result[0]['email_address'], name: result[0]['name'])
  end

  def self.find(id:)
    return nil unless id

    result = DatabaseConnection.query('SELECT * FROM users WHERE id = $1', [id])
    User.new(id: result[0]['id'], email_address: result[0]['email_address'], name: result[0]['name'])
  end
end
