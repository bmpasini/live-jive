User.create(username: "bmpasini", name: "Bruno Macedo Pasini", year_of_birth: 1991, email: "bmpasini@nyu.edu", password_digest: "password", remember_digest: "password", city_of_birth: "Sao Paulo",reputation_score: 10, is_admin?: true, last_login_at: Time.now())

499.times do |n|
  name  = Faker::Name.name
  username = name.split(' ').join.downcase
  email = Faker::Internet.email
  password = "password"
  city = Faker::Address.city
  yob = 1950+rand(55)
  rep = rand(10)
  User.create!(name: name,
  						 username: username,
               email: email,
               password: password,
               password_confirmation: password,
               city: city,
               year_of_birth: yob,
               reputation_score: rep,
               is_admin?: false,
               last_login_at: Time.now()
               )
end

Band.create(bandname: "bobmarley", name: "Bob Marley", bio: "The creator of reggae music", website: "http://www.bobmarley.com/", email: "bobmarley@gmail.com", password_digest: "password", remember_digest: "password", identity_confirmed?: true)
Band.create(bandname: "damianmarley", name: "Damian Marley", bio: "The son of the creator of reggae music", website: "http://www.damianmarley.com/", email: "damianmarley@gmail.com", password_digest: "password", remember_digest: "password", identity_confirmed?: true)
Band.create(bandname: "ziggymarley", name: "Ziggy Marley", bio: "Another son of the creator of reggae music", website: "http://www.ziggymarley.com/", email: "ziggymarley@gmail.com", password_digest: "password", remember_digest: "password", identity_confirmed?: true)

297.times do |n|
  name  = Faker::App.name
  bandname = name.split(' ').join.downcase
  email = Faker::Internet.email
  password = "password"
  bio = Faker::Lorem.paragraph(5)
  website = Faker::Internet.domain_name
  User.create!(name:  name,
  						 bandname: bandname,
               email: email,
               password:              password,
               password_confirmation: password,
               bio: bio,
               website: website,
               identity_confirmed?: true,
               last_login_at: Time.now()
               )
end

Concert.create(title: "Awesome concert 1", description: "Popular show", location_name: "Madison Square Garden", ccity: "New York City", buy_tickets_website: "http://www.tickets.com/")
Concert.create(title: "Awesome concert 2", description: "Popular show", location_name: "Lincoln Center", ccity: "New York City", buy_tickets_website: "http://www.tickets.com/")
Concert.create(title: "Awesome concert 3", description: "Popular show", location_name: "Broadway", ccity: "New York City", buy_tickets_website: "http://www.tickets.com/")

297.times do |n|
  title  = Faker::App.name
  description = Faker::Lorem.paragraph(5)
  location_name = Faker::App.name
  ccity = Faker::Address.city
  website = Faker::Internet.domain_name
  User.create!(title:  title,
  						 description: description,
               location_name: location_name,
               ccity: ccity,
               buy_tickets_website: website,
               )
end

Tickets.create(tier: "VIP", price: 300, how_many_left: 27, concert_id: 1)
Tickets.create(tier: "Regular", price: 100, how_many_left: 52, concert_id: 1)

303.times do |n|
  concert_id = n
  tier = ["VIP", "Confort", "Pavillion", "Front Row", "Lounge"].sample
  price = 50+rand(500)
  how_many_left = rand(1000)
  User.create!(tier:  tier,
  						 price: price,
               how_many_left: how_many_left,
               concert_id: concert_id
               )
end

Genre.create(genre: "Jazz", subgenre: "Jazz")
Genre.create(genre: "Jazz", subgenre: "Free Jazz")
Genre.create(genre: "Jazz", subgenre: "Bebob")
Genre.create(genre: "Jazz", subgenre: "Cool Jazz")
Genre.create(genre: "Reggae", subgenre: "Reggae")
Genre.create(genre: "Reggae", subgenre: "Dancehall")

Fanships.create(band_id: 1, fan_id: 1)
Fanships.create(band_id: 2, fan_id: 1)
Fanships.create(band_id: 1, fan_id: 2)
Fanships.create(band_id: 2, fan_id: 2)
Fanships.create(band_id: 3, fan_id: 2)

Lineup.create(band_id: 1, concert_id: 1)
Lineup.create(band_id: 2, concert_id: 1)
Lineup.create(band_id: 1, concert_id: 2)
Lineup.create(band_id: 2, concert_id: 3)
Lineup.create(band_id: 3, concert_id: 3)

ConcertGoings.create(goer_id: 1, concert_id: 1)
ConcertGoings.create(goer_id: 1, concert_id: 2)
ConcertGoings.create(goer_id: 2, concert_id: 2)

ConcertList.create(title: "Reggae Shows", description: "Just the best of reggae.")
ConcertList.create(title: "Bob Marley and Sons", description: "All shows of the Marley Family.")

Recommendation.create(concert_id: 1,concert_list_id: 1)
Recommendation.create(concert_id: 2,concert_list_id: 1)
Recommendation.create(concert_id: 1,concert_list_id: 2)
Recommendation.create(concert_id: 2,concert_list_id: 2)
Recommendation.create(concert_id: 3,concert_list_id: 2)

UserLikesGenre.create(user_id: 1, genre_id: 5)
UserLikesGenre.create(user_id: 1, genre_id: 6)
UserLikesGenre.create(user_id: 2, genre_id: 1)
UserLikesGenre.create(user_id: 2, genre_id: 2)
UserLikesGenre.create(user_id: 2, genre_id: 3)
UserLikesGenre.create(user_id: 2, genre_id: 4)

BandPlaysGenre.create(band_id: 1,genre_id: 5)
BandPlaysGenre.create(band_id: 2,genre_id: 5)
BandPlaysGenre.create(band_id: 2,genre_id: 6)

UserRelationship.create(follower_id: 1,followed_id: 2)
UserRelationship.create(follower_id: 2,followed_id: 1)