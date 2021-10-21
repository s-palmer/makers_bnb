# frozen_string_literal: true
require_relative 'booking_calendar'

class Space
  
  attr_reader :id, :name, :description, :price, :user_id, :available_from, :available_to, :url

  def initialize(id:, name:, description:, price:, available_from:, available_to:, user_id:, url:)
    @id = id
    @name = name
    @description = description
    @price = price
    @available_from = available_from
    @user_id = user_id
    @available_to = available_to
    @url = url
  end

  def self.create(name:, description:, price:, available_from:, available_to:, user_id:, url:)
    result = DatabaseConnection.query(
      "INSERT INTO spaces(
        name, description, price, available_from, available_to, user_id, url)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        RETURNING id, name, description, price, available_from, available_to, user_id, url;",
      [name, description, price, available_from, available_to, user_id, url]
    )
    Space.new(
      id: result[0]['id'],
      name: result[0]['name'],
      description: result[0]['description'],
      price: result[0]['price'],
      available_to: result[0]['available_from'],
      available_from: result[0]['available_to'],
      user_id: result[0]['user_id'],
      url: result[0]['url']
    )
  end

  def self.all
    spaces = DatabaseConnection.query('SELECT * FROM spaces;', [])
    spaces.map do |space|
      Space.new(
        id: space['id'],
        name: space['name'],
        description: space['description'],
        price: space['price'],
        available_from: space['available_from'],
        available_to: space['available_to'],
        user_id: space['user_id'],
        url: space['url']
      )
    end
  end

  def self.filter(date:)
    filter_date = date
    spaces = DatabaseConnection.query("SELECT * FROM spaces WHERE available_from <= '#{filter_date}' AND available_to >= '#{filter_date}';", [])
    spaces.map do |space|
      Space.new(
        id: space['id'],
        name: space['name'],
        description: space['description'],
        price: space['price'],
        available_from: space['available_from'],
        available_to: space['available_to'],
        user_id: space['user_id'],
        url: space['url']
      )
    end
  end


  def self.find(id:)
    result = DatabaseConnection.query('SELECT * FROM spaces WHERE id = ($1)', [id])
    result.map do |space|
      Space.new(
          id: space['id'],
          name: space['name'],
          description: space['description'],
          price: space['price'],
          available_from: space['available_from'],
          available_to: space['available_to'],
          user_id: space['user_id'],
          url: space['url']
        )
      end
  end

  def self.mine(id:)
    spaces = DatabaseConnection.query('SELECT * FROM spaces WHERE user_id = $1;', [id])
    spaces.map do |space|
      Space.new(
        id: space['id'],
        name: space['name'],
        description: space['description'],
        price: space['price'],
        available_from: space['available_from'],
        available_to: space['available_to'],
        user_id: space['user_id'],
        url: space['url']
      )
    end
  end

  def self.update(space:)
    DatabaseConnection.query(
      'UPDATE spaces
        SET name = $1, description = $2, price = $3, url = $4
        WHERE id = $5;',
      [space.name, space.description, space.price, space.url, space.user_id])
  end
end
