SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS bands;
DROP TABLE IF EXISTS concerts;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS fanships;
DROP TABLE IF EXISTS lineups;
DROP TABLE IF EXISTS concert_goings;
DROP TABLE IF EXISTS recommendations;
DROP TABLE IF EXISTS concert_lists;
DROP TABLE IF EXISTS user_likes_genres;
DROP TABLE IF EXISTS band_plays_genres;
DROP TABLE IF EXISTS user_relationships;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE users (
  id int(10) NOT NULL AUTO_INCREMENT,
  username varchar(40),
  name varchar(40),
  year_of_birth int(10),
  email varchar(40),
  password_digest varchar(40), -- CHANGED!!!
  remember_digest varchar(40), -- CHANGED!!!
  reset_digest varchar(40), -- CHANGED!!!
  city_of_birth varchar(40),
  reputation_score int(10),
  is_admin BINARY,
  reset_sent_at DATETIME, -- CHANGED!!!
  penultimate_login_at DATETIME, -- CHANGED!!!
  last_login_at DATETIME,
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE bands (
  id int(10) NOT NULL AUTO_INCREMENT,
  bandname varchar(40),
  password_digest varchar(40), -- CHANGED!!!
  remember_digest varchar(40), -- CHANGED!!!
  activation_digest varchar(40), -- CHANGED!!!
  reset_digest varchar(40), -- CHANGED!!!
  name varchar(40),
  bio varchar(100), -- CHANGED!!!
  website varchar(40),
  email varchar(40),
  identity_confirmed BINARY,
  activated_at DATETIME, -- CHANGED!!!
  reset_sent_at DATETIME, -- CHANGED!!!
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE concerts (
  id int(10) NOT NULL AUTO_INCREMENT,
  description varchar(100), -- CHANGED!!!
  cdatetime DATETIME, -- CHANGED!!!
  location_name varchar(40),
  ccity varchar(40),
  buy_tickets_website varchar(40),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE tickets (
  id int(10) NOT NULL AUTO_INCREMENT,
  concert_id int(10),
  tier varchar(40), -- CHANGED!!! - reserved word in Rails
  price int(10),
  how_many_left int(10),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE genres (
  id int(10) NOT NULL AUTO_INCREMENT,
  genre varchar(40),
  subgenre varchar(40),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE fanships (
  id int(10) NOT NULL AUTO_INCREMENT,
  band_id int(10),
  fan_id int(10),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE lineups (
  id int(10) NOT NULL AUTO_INCREMENT,
  band_id int(10),
  concert_id int(10),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE concert_goings (
  id int(10) NOT NULL AUTO_INCREMENT,
  review varchar(40),
  rating int(10),
  goer_id int(10),
  concert_id int(10),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE concert_lists (
  id int(10) NOT NULL AUTO_INCREMENT,
  list_owner_id int(10),
  title varchar(40),
  description varchar(100),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE recommendations (
  id int(10) NOT NULL AUTO_INCREMENT,
  concert_id int(10),
  concert_list_id int(10),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE user_likes_genres (
  id int(10) NOT NULL AUTO_INCREMENT,
  user_id int(10),
  genre_id int(10),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE band_plays_genres (
  id int(10) NOT NULL AUTO_INCREMENT,
  band_id int(10),
  genre_id int(10),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE user_relationships ( -- CHANGED!!!!
  id int(10) NOT NULL AUTO_INCREMENT,
  follower_id int(10),
  followed_id int(10),
  created_at DATETIME,
  updated_at DATETIME,
  PRIMARY KEY (id)
);

ALTER TABLE tickets ADD FOREIGN KEY (concert_id) REFERENCES concerts (id);
ALTER TABLE fanships ADD FOREIGN KEY (band_id) REFERENCES bands (id);
ALTER TABLE fanships ADD FOREIGN KEY (fan_id) REFERENCES users (id);
ALTER TABLE lineups ADD FOREIGN KEY (band_id) REFERENCES bands (id);
ALTER TABLE lineups ADD FOREIGN KEY (concert_id) REFERENCES concerts (id);
ALTER TABLE concert_goings ADD FOREIGN KEY (goer_id) REFERENCES users (id);
ALTER TABLE concert_goings ADD FOREIGN KEY (concert_id) REFERENCES concerts (id);
ALTER TABLE recommendations ADD FOREIGN KEY (concert_id) REFERENCES concerts (id);
ALTER TABLE recommendations ADD FOREIGN KEY (concert_list_id) REFERENCES concert_lists (id);
ALTER TABLE concert_lists ADD FOREIGN KEY (list_owner_id) REFERENCES users (id);
ALTER TABLE user_likes_genres ADD FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE user_likes_genres ADD FOREIGN KEY (genre_id) REFERENCES genres (id);
ALTER TABLE band_plays_genres ADD FOREIGN KEY (band_id) REFERENCES bands (id);
ALTER TABLE band_plays_genres ADD FOREIGN KEY (genre_id) REFERENCES genres (id);
ALTER TABLE user_relationships ADD FOREIGN KEY (follower_id) REFERENCES users (id);
ALTER TABLE user_relationships ADD FOREIGN KEY (followed_id) REFERENCES users (id);

-- ---
-- Test Data
-- ---

INSERT INTO users VALUES (1,'bmpasini','bruno pasini',1991,'bmpasini@nyu.edu','password','sao paulo',10,TRUE,NOW(),NOW(),NOW(),NOW());
INSERT INTO users VALUES (2,'bmacedo','bruno macedo',1991,'bmpasini@nyu.edu','password','sao paulo',10,FALSE,NOW(),NOW(),NOW(),NOW());
INSERT INTO bands VALUES (1,'bobmarley','Bob Marley','The creator of reggae music','http://www.bobmarley.com/','bobmarley@gmail.com',1,NOW(),NOW());
INSERT INTO bands VALUES (2,'damianmarley','Damian Marley','The son of the creator of reggae music','http://www.damianmarley.com/','damianmarley@gmail.com',1,NOW(),NOW());
INSERT INTO bands VALUES (3,'ziggymarley','Ziggy Marley','Another son of the creator of reggae music','http://www.ziggymarley.com/','ziggymarley@gmail.com',1,NOW(),NOW());
INSERT INTO concerts VALUES (1,DATE_ADD(DATE(NOW()),INTERVAL 10 DAY),TIME(NOW()),'Madison Square Garden','New York City','http://www.tickets.com/',NOW(),NOW());
INSERT INTO concerts VALUES (2,DATE_ADD(DATE(NOW()),INTERVAL 20 DAY),TIME(NOW()),'Lincoln Center','New York City','http://www.tickets.com/',NOW(),NOW());
INSERT INTO concerts VALUES (3,DATE_ADD(DATE(NOW()),INTERVAL 30 DAY),TIME(NOW()),'Broadway','New York City','http://www.tickets.com/',NOW(),NOW());
INSERT INTO tickets VALUES (1,1,'VIP',300,27,NOW(),NOW());
INSERT INTO tickets VALUES (2,1,'Regular',100,52,NOW(),NOW());
INSERT INTO tickets VALUES (3,1,'VIP',200,127,NOW(),NOW());
INSERT INTO tickets VALUES (4,1,'Regular',50,152,NOW(),NOW());
INSERT INTO genres VALUES (1,'Jazz','Jazz',NOW(),NOW());
INSERT INTO genres VALUES (2,'Jazz','Free Jazz',NOW(),NOW());
INSERT INTO genres VALUES (3,'Jazz','Bebob',NOW(),NOW());
INSERT INTO genres VALUES (4,'Jazz','Cool Jazz',NOW(),NOW());
INSERT INTO genres VALUES (5,'Reggae','Reggae',NOW(),NOW());
INSERT INTO genres VALUES (6,'Reggae','Dancehall',NOW(),NOW());
INSERT INTO fanships VALUES (1,1,1,NOW(),NOW());
INSERT INTO fanships VALUES (2,2,1,NOW(),NOW());
INSERT INTO fanships VALUES (3,1,2,NOW(),NOW());
INSERT INTO fanships VALUES (4,2,2,NOW(),NOW());
INSERT INTO fanships VALUES (5,3,2,NOW(),NOW());
INSERT INTO lineups VALUES (1,1,1,NOW(),NOW());
INSERT INTO lineups VALUES (2,2,1,NOW(),NOW());
INSERT INTO lineups VALUES (3,1,2,NOW(),NOW());
INSERT INTO lineups VALUES (4,2,3,NOW(),NOW());
INSERT INTO lineups VALUES (5,3,3,NOW(),NOW());
INSERT INTO concert_goings VALUES (1,NULL,NULL,1,1,NOW(),NOW());
INSERT INTO concert_goings VALUES (2,NULL,NULL,1,2,NOW(),NOW());
INSERT INTO concert_goings VALUES (3,NULL,NULL,2,2,NOW(),NOW());
INSERT INTO concert_lists VALUES (1,1,'Reggae Shows','Just the best of reggae.',NOW(),NOW());
INSERT INTO concert_lists VALUES (2,2,'Bob Marley and Sons','All shows of the Marley Family.',NOW(),NOW());
INSERT INTO recommendations VALUES (1,1,1,NOW(),NOW());
INSERT INTO recommendations VALUES (2,2,1,NOW(),NOW());
INSERT INTO recommendations VALUES (3,1,2,NOW(),NOW());
INSERT INTO recommendations VALUES (4,2,2,NOW(),NOW());
INSERT INTO recommendations VALUES (5,3,2,NOW(),NOW());
INSERT INTO user_likes_genres VALUES (1,1,5,NOW(),NOW());
INSERT INTO user_likes_genres VALUES (2,1,6,NOW(),NOW());
INSERT INTO user_likes_genres VALUES (3,2,1,NOW(),NOW());
INSERT INTO user_likes_genres VALUES (4,2,2,NOW(),NOW());
INSERT INTO user_likes_genres VALUES (5,2,3,NOW(),NOW());
INSERT INTO user_likes_genres VALUES (6,2,4,NOW(),NOW());
INSERT INTO band_plays_genres VALUES (1,1,5,NOW(),NOW());
INSERT INTO band_plays_genres VALUES (2,2,5,NOW(),NOW());
INSERT INTO band_plays_genres VALUES (3,2,6,NOW(),NOW());
INSERT INTO user_relationships VALUES (1,1,2,NOW(),NOW());
INSERT INTO user_relationships VALUES (2,2,1,NOW(),NOW());

-- INSERT INTO users (id,username,name,year_of_birth,email,password,city_of_birth,reputation_score,is_admin,last_login_at,current_login_at,created_at,updated_at) VALUES ('','','','','','','','','','','','');
-- INSERT INTO bands (id,bandname,name,bio,website,email,identity_confirmed,created_at,updated_at) VALUES ('','','','','','','','','');
-- INSERT INTO concerts (id,cdate,ctime,location_name,ccity,buy_tickets_website,created_at,updated_at) VALUES ('','','','','','','');
-- INSERT INTO tickets (id,concert_id,tier,price,how_many_left,created_at,updated_at) VALUES ('','','','','','','');
-- INSERT INTO genres (id,genre,subgenre,created_at,updated_at) VALUES ('','','','','');
-- INSERT INTO fanships (id,band_id,fan_id,created_at,updated_at) VALUES ('','','','','');
-- INSERT INTO lineups (id,band_id,concert_id,created_at,updated_at) VALUES ('','','','','');
-- INSERT INTO concert_goings (id,review,rating,goer_id,concert_id,created_at,updated_at) VALUES ('','','','','','','');
-- INSERT INTO recommendations (id,concert_id,concert_list_id,created_at,updated_at) VALUES ('','','','','');
-- INSERT INTO concert_lists (id,list_owner_id,title,description,created_at,updated_at) VALUES ('','','','','','');
-- INSERT INTO user_likes_genres (id,user_id,genre_id,created_at,updated_at) VALUES ('','','','','');
-- INSERT INTO band_plays_genres (id,band_id,genre_id,created_at,updated_at) VALUES ('','','','','');
-- INSERT INTO user_relationships (id,follower_id,followed_id,created_at,updated_at) VALUES ('','','','','');

-- Recommend to the user those concerts in the categories the user likes that were recommended in many lists by other users


-- ---
-- Preparred Statement Queries
-- ---

-- Write queries that users need to sign up, to create or edit their profiles, to follow another user, to become
-- fan of a band, and to post a review and rating.

-- User sign up or create his profile

INSERT INTO users (username,name,year_of_birth,email,password,city_of_birth,reputation_score,is_admin,last_login_at,current_login_at,created_at,updated_at)
VALUES (?,?,?,?,?,?,0,FALSE,NULL,NOW(),NOW(),NOW());
-- Binded to (username,name,year_of_birth,email,password,city_of_birth)

-- Band sign up or create their profile

INSERT INTO bands (bandname,name,bio,website,email,identity_confirmed,created_at,updated_at)
VALUES (?,?,?,?,?,FALSE,NOW(),NOW());
-- Binded to (bandname,name,bio,website,email)

-- User edit his profile

UPDATE users
SET name=?,year_of_birth=?,email=?,password=?,city_of_birth=?,updated_at=NOW()
WHERE id=?;
-- Binded to (name,year_of_birth,email,password,city_of_birth,id)

-- Band edit their profile

UPDATE bands
SET name=?,bio=?,website=?,email=?,updated_at=NOW()
WHERE id = ?;
-- Binded to (name,bio,website,email,id)

-- User follow another user

INSERT INTO user_relationships (follower_id,followed_id,created_at,updated_at)
VALUES (?,?,NOW(),NOW());
-- Binded to (follower_id,followed_id)

-- User become fan of a band

INSERT INTO fanships (band_id,fan_id,created_at,updated_at)
VALUES (?,?,NOW(),NOW());
-- Binded to (band_id,fan_id)

-- User post a review and rating

UPDATE concert_goings
SET review=?,rating=?,updated_at=NOW()
WHERE goer_id=? AND concert_id=?;
-- Binded to (review,rating,goer_id,concert_id)

-- When user login

UPDATE users
SET current_login_at=NOW()
WHERE id=?;
-- Binded to (user_id)

-- When user logout

UPDATE users
SET last_login_at=current_login_at,current_login_at=NULL
WHERE id=?;
-- Binded to (user_id)

-- Band and Concert Data: Write queries that bands can use to post new concerts, and queries that users can use to post user data (with a check on the user’s trust level), to create a list of recommended concerts, and to add a new concert to an existing list.

-- Band post new concerts

INSERT INTO concerts (cdate,ctime,location_name,ccity,buy_tickets_website,created_at,updated_at)
VALUES (?,?,?,?,?,NOW(),NOW());
-- Binded to (cdate,ctime,location_name,ccity,buy_tickets_website)

-- User or band update an existing concert

UPDATE concerts
SET cdate=?,ctime=?,location_name=?,ccity=?,buy_tickets_website=?,updated_at=NOW()
WHERE id=?;
-- Binded to (cdate,ctime,location_name,ccity,buy_tickets_website,id)

-- User create a list of recommended concerts

INSERT INTO concert_lists (list_owner_id,title,description,created_at,updated_at) VALUES (?,?,?,NOW(),NOW());
-- Binded to (list_owner_id,title,description)
INSERT INTO recommendations (concert_id,concert_list_id,created_at,updated_at) VALUES (?,?,NOW(),NOW());
-- Binded to (concert_id,concert_list_id)

-- User add a new concert to an existing list

INSERT INTO recommendations (concert_id,concert_list_id,created_at,updated_at) VALUES (?,?,NOW(),NOW());
-- Binded to (concert_id,concert_list_id)

-- Browse/Search Queries: Write three queries that a user could use when accessing content in your system. For example,
-- a user might want to see all Jazz concerts in a certain city during the next week, or see all concerts recommended
-- by people they follow during the next month, or see all newly posted concerts since the last time they logged in.

-- See all concerts from a specific genre in a certain city during the next week (next 7 days from now)
SELECT concerts.id, cdate, ctime, location_name,ccity, ccity, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
INNER JOIN lineups ON (concerts.id = lineups.concert_id)
INNER JOIN bands ON (bands.id = lineups.band_id)
INNER JOIN band_plays_genres ON (bands.id = band_plays_genres.band_id)
INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
WHERE genre = ? AND ccity = ? AND cdate >= DATE(NOW()) AND cdate <= DATE_ADD(DATE(NOW()),INTERVAL 7 DAY);
-- Binded to (genre, city)

-- See all concerts from a specific subgenre in a certain city in the following week (next 7 days from now)
SELECT concerts.id, cdate, ctime, location_name, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
INNER JOIN lineups ON (concerts.id = lineups.concert_id)
INNER JOIN bands ON (bands.id = lineups.band_id)
INNER JOIN band_plays_genres ON (bands.id = band_plays_genres.band_id)
INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
WHERE subgenre = ? AND ccity = ? AND cdate >= DATE(NOW()) AND cdate <= DATE_ADD(DATE(NOW()),INTERVAL 7 DAY);
-- Binded to (subgenre, concert_city)

SELECT * FROM concerts
INNER JOIN lineups ON (concerts.id = lineups.concert_id)
INNER JOIN bands ON (bands.id = lineups.band_id)
INNER JOIN band_plays_genres ON (bands.id = band_plays_genres.band_id)
INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
WHERE subgenre = ? AND genre = ?


--------------------------------------------------------------------------------------------------------------
-- See all concerts from a specific subgenre in a certain city in the following week (next 7 days from now)
SELECT concerts.id, cdate, ctime, location_name, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
INNER JOIN lineups ON (concerts.id = lineups.concert_id)
INNER JOIN bands ON (bands.id = lineups.band_id)
INNER JOIN band_plays_genres ON (bands.id = band_plays_genres.band_id)
INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
WHERE subgenre = :subgenre AND ccity = :city AND cdate >= :from_date AND cdate <= :to_date
--------------------------------------------------------------------------------------------------------------


-- See all concerts recommended by people they follow during the next month (next 1 month from now)
SELECT concerts.id, cdate, ctime, location_name, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
INNER JOIN recommendations ON (recommendations.concert_id = concerts.id)
INNER JOIN concert_lists ON (concert_lists.id = recommendations.concert_list_id)
INNER JOIN user_relationships ON (user_relationships.followed_id = concert_lists.list_owner_id)
INNER JOIN users ON (user_relationships.follower_id = users.id)
WHERE users.id = ? AND cdate <= DATE_ADD(DATE(NOW()),INTERVAL 1 MONTH);
-- Binded to (user_id)

-- See all newly posted concerts since the last time they logged in
SELECT concerts.id, cdate, ctime, location_name, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
WHERE concerts.created_at >= (SELECT last_login_at
                              FROM users
                              WHERE users.id = ?);
-- Binded to (user_id)

-- System Recommendations: Write two or three queries that the system could use to recommend to a particular user
-- bands and concerts that the user might be interested in, given past behavior by the user. For example, the system could
-- recommend to the user those concerts in the categories the user likes that were recommended in many lists by other
-- users. Or the system could suggest bands that were liked or who concerts were highly rated by other users that had
-- similar tastes to this user in the past (in terms of being fans and rating concerts). Note there is an entire area called
-- Recommender Systems in Computer Science that studies such problems – you may want to look up some very basic
-- techniques in this area to get some ideas on what to do here.

-- Recommend to the user those concerts in the categories the user likes that were recommended in many lists by other users
-- Here we are going to retrieve all concerts that have bands who play genres that the user likes, which have been included in at least 2 recommended lists
SELECT concerts.id, cdatetime, location_name, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
WHERE concerts.id IN (SELECT concerts2.id
                      FROM concerts concerts2
                      INNER JOIN recommendations ON (recommendations.concert_id = concerts2.id)
                      INNER JOIN lineups ON (lineups.concert_id = concerts2.id)
                      INNER JOIN bands ON (bands.id = lineups.band_id)
                      INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands.id)
                      INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
                      WHERE genres.genre IN (SELECT genres2.genre
                                             FROM genres genres2
                                             INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id)
                                             INNER JOIN users ON (users.id = user_likes_genres.user_id)
                                             WHERE users.id = 1)
                      GROUP BY concerts2.id, recommendations.concert_list_id
                      HAVING COUNT(*) >= 5);
-- Bind to (user_id)

-- Recommend to the user those concerts in the categories the user likes that were recommended in lists of followed users
-- Here we are going to retrieve all concerts that have bands who play genres that the user likes, which have been included in recommended lists of users he follows
SELECT concerts.id, cdatetime, location_name, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
WHERE concerts.id IN (SELECT concerts2.id
                      FROM concerts concerts2
                      INNER JOIN recommendations ON (recommendations.concert_id = concerts2.id)
                      INNER JOIN lineups ON (lineups.concert_id = concerts2.id)
                      INNER JOIN bands ON (bands.id = lineups.band_id)
                      INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands.id)
                      INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
                      WHERE genres.genre IN (SELECT genres2.genre
                                             FROM genres genres2
                                             INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id)
                                             INNER JOIN users ON (users.id = user_likes_genres.user_id)
                                             WHERE users.id = ?)
                      AND concerts2.id IN (SELECT recommendations2.concert_id
                                           FROM recommendations recommendations2
                                           WHERE recommendations2.concert_list_id IN (SELECT concert_lists.id
                                                                                      FROM concert_lists
                                                                                      WHERE concert_lists.list_owner_id IN (SELECT users2.id
                                                                                                              FROM users users2
                                                                                                              WHERE users2.id IN (SELECT user_relationships.followed_id
                                                                                                                                  FROM user_relationships
                                                                                                                                  WHERE user_relationships.follower_id = ?
                                                                                                                                 )
                                                                                                              )
                                                                                      )
                                          )
                        )

SELECT concerts.id, cdatetime, location_name, buy_tickets_website, concerts.created_at, concerts.updated_at FROM concerts WHERE concerts.id IN (SELECT concerts2.id FROM concerts concerts2 INNER JOIN recommendations ON (recommendations.concert_id = concerts2.id) INNER JOIN lineups ON (lineups.concert_id = concerts2.id) INNER JOIN bands ON (bands.id = lineups.band_id) INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands.id) INNER JOIN genres ON (genres.id = band_plays_genres.genre_id) WHERE genres.genre IN (SELECT genres2.genre FROM genres genres2 INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id) INNER JOIN users ON (users.id = user_likes_genres.user_id) WHERE users.id = 1) AND concerts2.id IN (SELECT recommendations2.concert_id FROM recommendations recommendations2 WHERE recommendations2.concert_list_id IN (SELECT concert_lists.id FROM concert_lists WHERE concert_lists.list_owner_id IN (SELECT users2.id FROM users users2 WHERE users2.id IN (SELECT user_relationships.followed_id FROM user_relationships WHERE user_relationships.follower_id = 1)))))


-- Suggest bands that were liked by other users that had similar tastes to this user in the past
-- Here we are going to retrieve all bands who play genres that the user likes and that have at least 2 other fans
SELECT bands.id,bandname,bands.name,bands.bio,website,bands.email,bands.created_at,bands.updated_at
FROM bands
WHERE bands.id IN (SELECT bands2.id
                   FROM bands bands2
                   INNER JOIN fanships ON (fanships.band_id = bands2.id)
                   INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands2.id)
                   INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
                   WHERE genres.genre IN (SELECT genres2.genre
                                          FROM genres genres2
                                          INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id)
                                          INNER JOIN users ON (users.id = user_likes_genres.user_id)
                                          WHERE users.id = ?)
                   GROUP BY fanships.band_id
                   HAVING COUNT(*) >= 2);
-- Bind to (user_id)

-- Suggest bands whose concerts were highly rated by other users that had similar tastes to this user in the past
-- Here we are going to retrieve all bands who have had at least 1 concert average rating greater or equal than 4
SELECT bands.id,bandname,bands.name,bands.bio,website,bands.email,bands.created_at,bands.updated_at
FROM bands
WHERE bands.id IN (SELECT DISTINCT bands2.id
                   FROM bands bands2
                   INNER JOIN lineups ON (lineups.band_id = bands2.id)
                   INNER JOIN concerts ON (concerts.id = lineups.concert_id)
                   INNER JOIN concert_goings ON (concert_goings.concert_id = concerts.id)
                   INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands2.id)
                   INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
                   WHERE genres.genre IN (SELECT genres2.genre
                                          FROM genres genres2
                                          INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id)
                                          INNER JOIN users ON (users.id = user_likes_genres.user_id)
                                          WHERE users.id = 1)
                   AND concert_goings.rating IS NOT NULL
                   GROUP BY concert_goings.concert_id
                   HAVING AVG(concert_goings.rating) >= 4);

-- Bind to (user_id)

SELECT bands.id,bandname,bands.name,bands.bio,website,bands.email,bands.created_at,bands.updated_at FROM bands WHERE bands.id IN (SELECT bands2.id FROM bands bands2 INNER JOIN lineups ON (lineups.band_id = bands2.id) INNER JOIN concerts ON (concerts.id = lineups.concert_id) INNER JOIN concert_goings ON (concert_goings.concert_id = concerts.id) INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands2.id) INNER JOIN genres ON (genres.id = band_plays_genres.genre_id) WHERE genres.genre IN (SELECT genres2.genre FROM genres genres2 INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id) INNER JOIN users ON (users.id = user_likes_genres.user_id) WHERE users.id = 1) AND concert_goings.rating IS NOT NULL GROUP BY concert_goings.concert_id HAVING AVG(concert_goings.rating) >= 4);


-- ---
-- Test of Queries Above
-- ---

-- Write queries that users need to sign up, to create or edit their profiles, to follow another user, to become
-- fan of a band, and to post a review and rating.

-- User sign up or create his profile

INSERT INTO users (username,name,year_of_birth,email,password,city_of_birth,reputation_score,is_admin,last_login_at,current_login_at,created_at,updated_at)
VALUES ('bmp339','bruno m pasini',NULL,'bmp339@nyu.edu','password','new york city',10,FALSE,NOW(),NULL,NOW(),NOW());
-- Binded to (username,name,year_of_birth,email,password,city_of_birth)

-- Band sign up or create their profile

INSERT INTO bands (bandname,name,bio,website,email,identity_confirmed,created_at,updated_at)
VALUES ('abovebeyond','above and beyond','Trance music.','aboveandbeyond.nu','aboveandbeyond@gmail.com',FALSE,NOW(),NOW());
-- Binded to (bandname,name,bio,website,email)

-- User edit his profile

UPDATE users
SET name='bruno macedo pasini',year_of_birth='1991',email='bmp339@nyu.edu',password='password',city_of_birth='sao paulo',updated_at=NOW()
WHERE id=3;
-- Binded to (name,year_of_birth,email,password,city_of_birth,id)

-- Band edit their profile
UPDATE bands
SET name='Above & Beyond',bio='Best trance music of Europe.',website='aboveandbeyond.nu',email='aboveandbeyond@gmail.com',updated_at=NOW()
WHERE id = 4;
-- Binded to (name,bio,website,email,id)

-- User follow another user

INSERT INTO user_relationships (follower_id,followed_id,created_at,updated_at)
VALUES (3,1,NOW(),NOW());
-- Binded to (follower_id,followed_id)

-- User become fan of a band
INSERT INTO fanships (band_id,fan_id,created_at,updated_at)
VALUES (1,3,NOW(),NOW());
-- Binded to (band_id,fan_id)

-- User post a review and rating

UPDATE concert_goings
SET review='Awesome show!!',rating=5,updated_at=NOW()
WHERE goer_id=1 AND concert_id=2;
-- Binded to (review,rating,goer_id,concert_id)

-- When user login

UPDATE users
SET current_login_at=NOW()
WHERE id=1;
-- Binded to (user_id)

-- When user logout

UPDATE users
SET last_login_at=current_login_at,current_login_at=NULL
WHERE id=1;
-- Binded to (user_id)

-- Band and Concert Data: Write queries that bands can use to post new concerts, and queries that users can use to post user data (with a check on the user’s trust level), to create a list of recommended concerts, and to add a new concert to an existing list.

-- Band post new concerts

INSERT INTO concerts (cdate,ctime,location_name,ccity,buy_tickets_website,created_at,updated_at)
VALUES (DATE(NOW()),TIME(NOW()),'casa da mae joana','new york city','casadamaejoana.com',NOW(),NOW());
-- Binded to (cdate,ctime,location_name,ccity,buy_tickets_website)

-- User or band update an existing concert

UPDATE concerts
SET cdate=DATE(NOW()),ctime=TIME(NOW()),location_name='casa',ccity='new york city',buy_tickets_website='casa.com',updated_at=NOW()
WHERE id=3;
-- Binded to (cdate,ctime,location_name,ccity,buy_tickets_website)

-- User create a list of recommended concerts

INSERT INTO concert_lists (list_owner_id,title,description,created_at,updated_at) VALUES (3,'Trance music','The best trance shows.',NOW(),NOW());
-- Binded to (list_owner_id,title,description)
INSERT INTO recommendations (concert_id,concert_list_id,created_at,updated_at) VALUES (3,3,NOW(),NOW());
-- Binded to (concert_id,concert_list_id)

-- User add a new concert to an existing list

INSERT INTO recommendations (concert_id,concert_list_id,created_at,updated_at) VALUES (1,3,NOW(),NOW());
-- Binded to (concert_id,concert_list_id)

-- Browse/Search Queries: Write three queries that a user could use when accessing content in your system. For example,
-- a user might want to see all Jazz concerts in a certain city during the next week, or see all concerts recommended
-- by people they follow during the next month, or see all newly posted concerts since the last time they logged in.

-- See all concerts from a specific genre in a certain city during the next week (next 7 days from now)

SELECT concerts.id, cdate, ctime, location_name,ccity, ccity, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
INNER JOIN lineups ON (concerts.id = lineups.concert_id)
INNER JOIN bands ON (bands.id = lineups.band_id)
INNER JOIN band_plays_genres ON (bands.id = band_plays_genres.band_id)
INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
WHERE genre = 'Reggae' AND ccity = 'New York City' AND cdate >= DATE(NOW()) AND cdate <= DATE_ADD(DATE(NOW()),INTERVAL 7 DAY);
-- Binded to (genre, city)

-- See all concerts from a specific subgenre in a certain city in the following week (next 7 days from now)

SELECT concerts.id, cdate, ctime, location_name, ccity, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
INNER JOIN lineups ON (concerts.id = lineups.concert_id)
INNER JOIN bands ON (bands.id = lineups.band_id)
INNER JOIN band_plays_genres ON (bands.id = band_plays_genres.band_id)
INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
WHERE subgenre = 'Dancehall' AND ccity = 'New York City' AND cdate >= DATE(NOW()) AND cdate <= DATE_ADD(DATE(NOW()),INTERVAL 7 DAY);
-- Binded to (subgenre, concert_city)

-- See all concerts recommended by people they follow during the next month (next 1 month from now)

SELECT concerts.id, cdate, ctime, location_name, ccity, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
INNER JOIN recommendations ON (recommendations.concert_id = concerts.id)
INNER JOIN concert_lists ON (concert_lists.id = recommendations.concert_list_id)
INNER JOIN user_relationships ON (user_relationships.followed_id = concert_lists.list_owner_id)
INNER JOIN users ON (user_relationships.follower_id = users.id)
WHERE users.id = 1 AND cdate <= DATE_ADD(DATE(NOW()),INTERVAL 1 MONTH);
-- Binded to (user_id)

-- See all newly posted concerts since the last time they logged in

SELECT concerts.id, cdate, ctime, location_name, ccity, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
WHERE concerts.created_at >= (SELECT last_login_at
                              FROM users
                              WHERE users.id = 1);
-- Binded to (user_id)

-- System Recommendations: Write two or three queries that the system could use to recommend to a particular user
-- bands and concerts that the user might be interested in, given past behavior by the user. For example, the system could
-- recommend to the user those concerts in the categories the user likes that were recommended in many lists by other
-- users. Or the system could suggest bands that were liked or who concerts were highly rated by other users that had
-- similar tastes to this user in the past (in terms of being fans and rating concerts). Note there is an entire area called
-- Recommender Systems in Computer Science that studies such problems – you may want to look up some very basic
-- techniques in this area to get some ideas on what to do here.

-- Recommend to the user those concerts in the categories the user likes that were recommended in many lists by other users
-- Here we are going to retrieve all concerts that have bands who play genres that the user likes, which have been included in at least 2 recommended lists

SELECT concerts.id, cdate, ctime, location_name, ccity, buy_tickets_website, concerts.created_at, concerts.updated_at
FROM concerts
WHERE concerts.id IN (SELECT concerts2.id
                      FROM concerts concerts2
                      INNER JOIN recommendations ON (recommendations.concert_id = concerts2.id)
                      INNER JOIN lineups ON (lineups.concert_id = concerts2.id)
                      INNER JOIN bands ON (bands.id = lineups.band_id)
                      INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands.id)
                      INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
                      WHERE genres.genre IN (SELECT genres2.genre
                                             FROM genres genres2
                                             INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id)
                                             INNER JOIN users ON (users.id = user_likes_genres.user_id)
                                             WHERE users.id = 1)
                      GROUP BY concerts2.id, recommendations.concert_list_id
                      HAVING COUNT(*) >= 2);
-- Bind to (user_id)

-- Suggest bands that were liked by other users that had similar tastes to this user in the past
-- Here we are going to retrieve all bands who play genres that the user likes and that have at least 2 other fans

SELECT bands.id,bandname,bands.name,bands.bio,website,bands.email,bands.created_at,bands.updated_at
FROM bands
WHERE bands.id IN (SELECT bands2.id
                   FROM bands bands2
                   INNER JOIN fanships ON (fanships.band_id = bands2.id)
                   INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands2.id)
                   INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
                   WHERE genres.genre IN (SELECT genres2.genre
                                          FROM genres genres2
                                          INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id)
                                          INNER JOIN users ON (users.id = user_likes_genres.user_id)
                                          WHERE users.id = 1)
                   GROUP BY fanships.band_id
                   HAVING COUNT(*) >= 2);
-- Bind to (user_id)

-- Suggest bands whose concerts were highly rated by other users that had similar tastes to this user in the past
-- Here we are going to retrieve all bands that plays genres liked by the user who have had at least 1 concert average rating greater or equal than 4

SELECT bands.id,bandname,bands.name,bands.bio,website,bands.email,bands.created_at,bands.updated_at
FROM bands
WHERE bands.id IN (SELECT bands2.id
                   FROM bands bands2
                   INNER JOIN lineups ON (lineups.band_id = bands2.id)
                   INNER JOIN concerts ON (concerts.id = lineups.concert_id)
                   INNER JOIN concert_goings ON (concert_goings.concert_id = concerts.id)
                   INNER JOIN band_plays_genres ON (band_plays_genres.band_id = bands2.id)
                   INNER JOIN genres ON (genres.id = band_plays_genres.genre_id)
                   WHERE genres.genre IN (SELECT genres2.genre
                                          FROM genres genres2
                                          INNER JOIN user_likes_genres ON (user_likes_genres.genre_id = genres2.id)
                                          INNER JOIN users ON (users.id = user_likes_genres.user_id)
                                          WHERE users.id = 1)
                   AND concert_goings.rating IS NOT NULL
                   GROUP BY concert_goings.id
                   HAVING AVG(concert_goings.rating) >= 4);
-- Bind to (user_id)


-- STORED PROCEDURES: Consider defining appropriate stored procedures for various common tasks. Each stored procedure should have a few
-- specified input parameters (such as the user name, or a set of keywords on which a search is performed, or the data for a new
-- entry that should be created, etc.), and should return a defined result. Note that in the second project, you have to call these
-- procedures from a web-based interface outside your database, so find out how to define stored procedures, how they can be
-- called, what restrictions there are, and what sort of technologies (like Java+JDBC, PHP, CGI) there are for interfacing from
-- a web server

CREATE PROCEDURE user_signup (IN uname VARCHAR(40), IN rname VARCHAR(40), IN birthyear INT(4), IN uemail VARCHAR(40), 
	IN pw VARCHAR(40), IN birthcity VARCHAR(40))
BEGIN
	INSERT INTO users (username,name,year_of_birth,email,password,city_of_birth,reputation_score,
					   is_admin,last_login_at,current_login_at,created_at,updated_at)
	VALUES (uname,rname,birthyear,uemail,pw,birthcity,FALSE,NULL,NOW(),NOW(),NOW())
END;




