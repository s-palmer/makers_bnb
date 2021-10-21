module SpaceHelper
  
def get_space_name(id:)
  space = DatabaseConnection.query("SELECT name FROM spaces WHERE id = $1;", [id])
  space.values[0][0]
end

def get_space_image_url(id:)
  space = DatabaseConnection.query("SELECT url FROM spaces WHERE id = $1;", [id])
  space.values[0][0]
end


end
