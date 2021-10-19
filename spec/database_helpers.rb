require 'pg'

def persisted_data(id:, table:)
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.query("SELECT * FROM #{table} WHERE ID = '#{id}';")
end
