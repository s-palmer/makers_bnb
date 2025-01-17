require_relative "../lib/user"
require_relative "../lib/space"

DatabaseConnection.setup("makers_bnb_development")
DatabaseConnection.query('TRUNCATE users, spaces, dates, bookings RESTART IDENTITY;', [])

user1 = User.create(email_address: "user1@example.com", name: "User1", password: "userpassword")
user2 = User.create(email_address: "user2@example.com", name: "User2", password: "userpassword")

space1 = Space.create(name: "Mountain Retreat", description: "Imagine escaping to the mountains for a relaxing, quiet retreat. Looking out from the cabin window at the scenic view, taking in all of its natural beauty.", price: "200", available_from: "2021-10-01", available_to: "2021-10-15", user_id: user1.id, url: "https://images.unsplash.com/photo-1558036117-15d82a90b9b1")

BookingCalendar.create(
  space_id: space1.id,
  start_date: "2021-10-01",
  end_date: "2021-10-15",
)

space2 = Space.create(name: "Ski Retreat", description: "France is the most popular Alpine country for British skiers and snowboarders.", price: "150", available_from: "2021-12-15", available_to: "2021-12-31", user_id: user1.id, url: "https://images.unsplash.com/photo-1550503736-c1a2c9033c03")

BookingCalendar.create(
  space_id: space2.id,
  start_date: "2021-12-15",
  end_date: "2021-12-31",
)

space3 = Space.create(name: "Luxury Beach Resort", description: "Imbued with luxury, elegance, charm, refinement, and located on the Croisette, facing the Mediterranean Sea and the Palais des Festivals.", price: "300", available_from: "2021-10-21", available_to: "2021-11-15", user_id: user2.id, url: "https://images.unsplash.com/photo-1525967304942-5e269b2dab58")

BookingCalendar.create(
  space_id: space3.id,
  start_date: "2021-10-21",
  end_date: "2021-11-15",
)

space4 = Space.create(name: "City Break", description: "Explore night markets, hop between temples and taste delicious bao buns.", price: "150", available_from: "2021-11-01", available_to: "2021-11-06", user_id: user2.id, url: "https://images.unsplash.com/photo-1598935898639-81586f7d2129")

BookingCalendar.create(
  space_id: space4.id,
  start_date: "2021-11-01",
  end_date: "2021-11-06",
)

space5 = Space.create(name: "Forest Cabin Hideaway", description: "A forest hideaway cabin is the ultimate staycation made for two. Whether it’s your anniversary, honeymoon or just an excuse to treat your special someone, carve out time to be together in serene natural surroundings.", price: "100", available_from: "2021-11-25", available_to: "2021-12-10", user_id: user2.id, url: "https://images.unsplash.com/photo-1568729937315-2ef5ee9cf4f2")

BookingCalendar.create(
  space_id: space5.id,
  start_date: "2021-11-25",
  end_date: "2021-12-10",
)

space6 = Space.create(name: "Desert Wellness Spa", description: "The natural deserts of the American Southwest are sublime destinations for restorative healing, boasting luxury resorts with meditation gardens, holistic body treatments, reflection pools, and stunning views.", price: "100", available_from: "2021-10-25", available_to: "2021-11-05", user_id: user1.id, url: "https://images.unsplash.com/photo-1470010762743-1fa2363f65ca")

BookingCalendar.create(
  space_id: space6.id,
  start_date: "2021-10-25",
  end_date: "2021-11-05",
)

