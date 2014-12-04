User.create(username: "bmpasini", name: "bruno pasini", year_of_birth: 1991, email: "bmpasini@nyu.edu", password: "password", password_confirmation: "password", city_of_birth: "sao paulo",reputation_score: 10, is_admin?: true, last_login_at: Time.now(), current_login_at: Time.now())
User.create(username: "bmacedo", name: "bruno macedo", year_of_birth: 1991, email: "bmpasini@nyu.edu", password: "password", password_confirmation: "password", city_of_birth: "sao paulo",reputation_score: 10, is_admin?: false, last_login_at: Time.now(), current_login_at: Time.now())


Band.create(bandname: "bobmarley", name: "Bob Marley", bio: "The creator of reggae music", website: "http://www.bobmarley.com/", email: "bobmarley@gmail.com", identity_confirmed?: true)
Band.create(bandname: "damianmarley", name: "Damian Marley", bio: "The son of the creator of reggae music", website: "http://www.damianmarley.com/", email: "damianmarley@gmail.com", identity_confirmed?: true)
Band.create(bandname: "ziggymarley", name: "Ziggy Marley", bio: "Another son of the creator of reggae music", website: "http://www.ziggymarley.com/", email: "ziggymarley@gmail.com", identity_confirmed?: true)

Concert.create(title: "Awesome concert 1", description: "Popular show", location_name: "Madison Square Garden", ccity: "New York City", buy_tickets_website: "http://www.tickets.com/")
Concert.create(title: "Awesome concert 2", description: "Popular show", location_name: "Lincoln Center", ccity: "New York City", buy_tickets_website: "http://www.tickets.com/")
Concert.create(title: "Awesome concert 3", description: "Popular show", location_name: "Broadway", ccity: "New York City", buy_tickets_website: "http://www.tickets.com/")

Tickets.create(tier: "VIP", price: 300, how_many_left: 27, concert_id: 1)
Tickets.create(tier: "Regular", price: 100, how_many_left: 52, concert_id: 1)
Tickets.create(tier: "VIP", price: 200, how_many_left: 127, concert_id: 2)
Tickets.create(tier: "Regular", price: 50, how_many_left: 152, concert_id: 2)
Tickets.create(tier: "VIP", price: 500, how_many_left: 222, concert_id: 3)
Tickets.create(tier: "Regular", price: 350, how_many_left: 727, concert_id: 3)

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