seeding_start = Time.now
User.create(username: "bmpasini", name: "Bruno Macedo Pasini", year_of_birth: 1991, email: "bmpasini@nyu.edu", password: "password", password_confirmation: "password", city_of_birth: "Sao Paulo",reputation_score: 10, is_admin?: true, penultimate_login_at: Time.now, last_login_at: Time.now)
User.create(username: "brunomacedo", name: "Bruno Macedo Pasini", year_of_birth: 1991, email: "bmpasini@gmail.com", password: "password", password_confirmation: "password", city_of_birth: "Sao Paulo",reputation_score: 10, is_admin?: false, penultimate_login_at: Time.now, last_login_at: Time.now)

# 498.times do |n|
98.times do |n|
  name  = Faker::Name.name
  username = name.split(' ').join('.').downcase
  until User.find_by(username: username).nil?
  	name  = Faker::Name.name
  	username = name.split(' ').join.downcase
  end
  email = Faker::Internet.email
  password = "password"
  city = Faker::Address.city
  yob = 1950+rand(55)
  rep = 1+rand(10)
  p User.create!(name: name,
	  						 username: username,
	               email: email,
	               password: password,
	               password_confirmation: password,
	               city_of_birth: city,
	               year_of_birth: yob,
	               reputation_score: rep,
	               penultimate_login_at: Time.now,
	               last_login_at: Time.now
	               )
end

Band.create(bandname: "bobmarley", name: "Bob Marley", bio: "The creator of reggae music", website: "http://www.bobmarley.com/", email: "bobmarley@gmail.com", password: "password", password_confirmation: "password", identity_confirmed?: true, activated_at: Time.now)
Band.create(bandname: "damianmarley", name: "Damian Marley", bio: "The son of the creator of reggae music", website: "http://www.damianmarley.com/", email: "damianmarley@gmail.com", password: "password", password_confirmation: "password", identity_confirmed?: true, activated_at: Time.now)
Band.create(bandname: "ziggymarley", name: "Ziggy Marley", bio: "Another son of the creator of reggae music", website: "http://www.ziggymarley.com/", email: "ziggymarley@gmail.com", password: "password", password_confirmation: "password", identity_confirmed?: true, activated_at: Time.now)


# 297.times do |n|
97.times do |n|
  name  = Faker::Company.name
  bandname = name.split(' ').join.downcase
  until Band.find_by(bandname: bandname).nil?
  	name  = Faker::Company.name
  	bandname = name.split(' ').join.downcase
  end
  email = Faker::Internet.email
  # email_hash = "cbd36e1ddee20d1580f560ea2a08e1b5"
  # api = Gravatar.new("bmpasini@gmail.com", :api_key => email_hash)
  password = "password"
  bio = Faker::Lorem.paragraph(1)
  website = Faker::Internet.domain_name
  p Band.create!(name:  name,
	  						 bandname: bandname,
	               email: email,
	               password:              password,
	               password_confirmation: password,
	               bio: bio,
	               website: website,
	               identity_confirmed?: true,
	               activated_at: Time.now
               )
end

Concert.create(title: "Awesome concert 1", description: "Popular show", location_name: "Madison Square Garden", ccity: "New York City", buy_tickets_website: "http://www.tickets.com/", cdatetime: Time.now)
Concert.create(title: "Awesome concert 2", description: "Popular show", location_name: "Lincoln Center", ccity: "New York City", buy_tickets_website: "http://www.tickets.com/", cdatetime: Time.now)
Concert.create(title: "Awesome concert 3", description: "Popular show", location_name: "Broadway", ccity: "New York City", buy_tickets_website: "http://www.tickets.com/", cdatetime: Time.now)

# 297.times do |n|
97.times do |n|
  title = Faker::Lorem.sentence(2, true, 2)[0..-2]
  description = Faker::Lorem.paragraph(1)
  location_name = Faker::Address.street_name
  cdatetime = [Time.now, 10.minutes.ago, 1.hour.ago, 2.hours.ago, 1.day.ago, 1.month.ago, 1.year.ago, 2.years.ago, 10.minutes.from_now, 1.hour.from_now, 2.hours.from_now, 2.hours.from_now, 1.day.from_now, 1.month.from_now, 1.year.from_now, 2.years.from_now].sample
  ccity = Faker::Address.city
  website = Faker::Internet.domain_name
  p Concert.create!(title: title,
		  						  description: description,
		                location_name: location_name,
		                cdatetime: cdatetime,
		                ccity: ccity,
		                buy_tickets_website: website,
		                )
end

# 300.times do |n|
Concert.all.each do |concert|
	["VIP", "Confort", "Pavillion", "Front Row", "Lounge"].each do |tier|
	  concert_id = concert.id
	  price = 50+rand(500)
	  how_many_left = rand(1000)
	  p Tickets.create!(tier:  tier,
			  						  price: price,
			                how_many_left: how_many_left,
			                concert_id: concert_id
			               )
	end
end

Genre.create(genre: "Jazz", subgenre: "Techno Jazz")
Genre.create(genre: "Jazz", subgenre: "Free Jazz")
Genre.create(genre: "Jazz", subgenre: "Bebob")
Genre.create(genre: "Jazz", subgenre: "Cool Jazz")
Genre.create(genre: "Reggae", subgenre: "Reggae")
Genre.create(genre: "Reggae", subgenre: "Dancehall")
Genre.create(genre: "Reggae", subgenre: "Roots")

LiveJiveGenre.clean_hashes.each do |genre|
	p Genre.create(genre)
end

# Fanships.create(band_id: 1, fan_id: 1)
# Fanships.create(band_id: 2, fan_id: 1)
# Fanships.create(band_id: 1, fan_id: 2)
# Fanships.create(band_id: 2, fan_id: 2)
# Fanships.create(band_id: 3, fan_id: 2)
Band.all.each do |band|
	band_id = band.id
	user_ids = Array.new
	User.all.each do |u|
		user_ids <<	u.id
	end
	(1+rand(20)).times do
		fan_id = user_ids.delete_at(rand(user_ids.length))
		p Fanships.create(band_id: band_id, fan_id: fan_id)
	end
end

# Lineup.create(band_id: 1, concert_id: 1)
# Lineup.create(band_id: 2, concert_id: 1)
# Lineup.create(band_id: 1, concert_id: 2)
# Lineup.create(band_id: 2, concert_id: 3)
# Lineup.create(band_id: 3, concert_id: 3)
Band.all.each do |band|
	band_id = band.id
	concert_ids = Array.new
	Concert.all.each do |c|
		concert_ids <<	c.id
	end
	(1+rand(20)).times do
		concert_id = concert_ids.delete_at(rand(concert_ids.length))
		p Lineup.create(concert_id: concert_id, band_id: band_id)
	end
end

# ConcertGoings.create(goer_id: 1, concert_id: 1)
# ConcertGoings.create(goer_id: 1, concert_id: 2)
# ConcertGoings.create(goer_id: 2, concert_id: 2)
User.all.each do |goer|
	goer_id = goer.id
	concert_ids = Array.new
	Concert.all.each do |c|
		concert_ids << c.id
	end
	(1+rand(20)).times do
		concert_id = concert_ids.delete_at(rand(concert_ids.length))
		rating = 1+rand(5) if (rand(2).to_bool && (Concert.find(concert_id).cdatetime < Time.now))
		review = Faker::Lorem.paragraph(1) if (rand(2).to_bool && (Concert.find(concert_id).cdatetime < Time.now))
		p ConcertGoings.create(goer_id: goer_id, concert_id: concert_id, rating: rating, review: review)
	end
end

ConcertList.create(title: "Reggae Shows", description: "Just the best of reggae.", list_owner_id: 1)
ConcertList.create(title: "Bob Marley and Sons", description: "All shows of the Marley Family.", list_owner_id: 1)
User.all.each do |list_owner|
	(1+rand(20)).times do |n|
	  title  = Faker::Company.name
	  description = Faker::Lorem.paragraph(1)
	  list_owner_id = list_owner.id
	  p ConcertList.create!(title:  title,
	  						 description: description,
	  						 list_owner_id: list_owner_id
	               )
	end
end


# Recommendation.create(concert_id: 1,concert_list_id: 1)
# Recommendation.create(concert_id: 2,concert_list_id: 1)
# Recommendation.create(concert_id: 1,concert_list_id: 2)
# Recommendation.create(concert_id: 2,concert_list_id: 2)
# Recommendation.create(concert_id: 3,concert_list_id: 2)
Concert.all.each do |concert|
	concert_id = concert.id
	concert_list_ids = Array.new
		ConcertList.all.each do |c|
			concert_list_ids <<	c.id
		end
	(1+rand(20)).times do
		concert_list_id = concert_list_ids.delete_at(rand(concert_list_ids.length))
		p Recommendation.create(concert_id: concert_id, concert_list_id: concert_list_id)
	end
end

# UserLikesGenre.create(user_id: 1, genre_id: 5)
# UserLikesGenre.create(user_id: 1, genre_id: 6)
# UserLikesGenre.create(user_id: 2, genre_id: 1)
# UserLikesGenre.create(user_id: 2, genre_id: 2)
# UserLikesGenre.create(user_id: 2, genre_id: 3)
# UserLikesGenre.create(user_id: 2, genre_id: 4)
User.all.each do |user|
	user_id = user.id
	genre_ids = Array.new
	Genre.all.each do |c|
		genre_ids <<	c.id
	end
	(1+rand(10)).times do
		genre_id = genre_ids.delete_at(rand(genre_ids.length))
		p UserLikesGenre.create(user_id: user_id, genre_id: genre_id)
	end
end

# BandPlaysGenre.create(band_id: 1,genre_id: 5)
# BandPlaysGenre.create(band_id: 2,genre_id: 5)
# BandPlaysGenre.create(band_id: 2,genre_id: 6)
Band.all.each do |band|
	band_id = band.id
	genre_ids = Array.new
	Genre.all.each do |c|
		genre_ids <<	c.id
	end
	(1+rand(4)).times do
		genre_id = genre_ids.delete_at(rand(genre_ids.length))
		p BandPlaysGenre.create(band_id: band_id, genre_id: genre_id)
	end
end

# UserRelationship.create(follower_id: 1,followed_id: 2)
# UserRelationship.create(follower_id: 2,followed_id: 1)
User.all.each do |follower|
	follower_id = follower.id
	followed_ids = Array.new
	User.all.each do |f|
		followed_ids <<	f.id if f.id != follower_id
	end
	(1+rand(20)).times do
		followed_id = followed_ids.delete_at(rand(followed_ids.length))
		p UserRelationship.create(follower_id: follower_id, followed_id: followed_id)
	end
end
puts "Seeding took #{Time.now - seeding_start} seconds"