class Space

  attr_reader :id, :name, :description, :price, :user_id

  def initialize(id:, name:, description:, price:, available_from:, available_to:, user_id:)
    @id = id
    @name = name
    @description = description
    @price = price
    @available_from = available_from
    @available_to = available_to
    @user_id = user_id
  end

  def self.create(name:, description:, price:, available_from:, available_to:)
    result = DatabaseConnection.query(
      "INSERT INTO spaces(
        name, description, price, available_from, available_to, user_id)
        VALUES ($1, $2, $3, $4, $5, $6)
        RETURNING id, name, description, price, available_from, available_to, user_id;",
      [name, description, price, available_from, available_to, 1]
      )
    Space.new(
      id: result[0]['id'],
      name: result[0]['name'],
      description: result[0]['description'],
      price: result[0]['price'],
      available_to: result[0]['available_from'],
      available_from: result[0]['available_to'],
      user_id: result[0]['user_id']
      )
  end

end