User.destroy_all
 Comment.destroy_all
 Joke.destroy_all
 Lesson.destroy_all
 Like.destroy_all
 Minion.destroy_all

#create users
#name, user_name, age, bio, cohort, member_since, password, num_of_minion_followed, minion_d, status
netaly = User.create(user_name: "Nutella", password: "1234567890")
francisco = User.create(user_name: "Zerocool",password: "1234567890")
tricia = User.create(user_name: "Patricia456",password: "1234567890")
manon = User.create(user_name: "Manon234",password: "1234567890")
donat = User.create(user_name: "Donut",password: "1234567890")
barbara = User.create(user_name: "Barbi",password: "1234567890")
karem = User.create(user_name: "Teflon",password: "1234567890")



#create jokes
#content, genre, like_id
joke1 = Joke.create(content: "Chuck Norris threw a grenade and killed 50 people, then it exploded.", genre: "Chuck Norris Fact")
joke2 = Joke.create(content: "An SQL query goes into a bar, walks up to two tables, and asks, “Can I join you?", genre: "SQL Joke")
joke3 = Joke.create(content: "Two bytes meet. The first byte asks, “Are you ill?”
The second byte replies, “No, just feeling a bit off.", genre: "Programing Joke")
joke4 = Joke.create(content: "When Chuck Norris is web surfing websites get the message “Warning: Internet Explorer has deemed this user to be malicious or dangerous. Proceed?", genre: "Chuck Norris Fact")
joke5 = Joke.create(content: "Chuck Norris writes code that optimizes itself.", genre: "Chuck Norris Fact")
joke6 = Joke.create(content: "All browsers support the hex definitions #chuck and #norris for the colors black and blue.", genre: "Chuck Norris Fact")
joke7 = Joke.create(content: "Chuck Norris’s beard can type 140 wpm.", genre: "Chuck Norris Fact")

#create lessons
#title, summary, location
lesson1 = Lesson.create(title:"Super Lab", summary: "Define two classes, one of which inherits from another.")
lesson2 = Lesson.create(title:"Advanced Class Methods Lab", summary:"Build custom class constructors.")
lesson3 = Lesson.create(title:"OO Cash Register", summary:"Build a class with instance methods.")
lesson4 = Lesson.create(title:"Pigeon Organizer Lab", summary:"Iterate over nested hashes. Sort and manipulate hashes")
lesson5 = Lesson.create(title:"Arrays of Hashes Lab", summary:"Recognize vocabulary term: array of hashes (AoH)")
lesson6 = Lesson.create(title:"Green Grocer Part 1", summary:"Translate data from AoH to AoH")
lesson7 = Lesson.create(title:"Green Grocer Part 2", summary:"Perform calculations based on AoH data")


#create comments 
#user_id, joke_id, like_id, content, posted
comment1 = Comment.create(content: "This joke was super funny!", user_id:francisco.id)
comment2 = Comment.create(content: "This joke was lame!", user_id:netaly.id)
comment3 = Comment.create(content: "Amazing!!!!", user_id:donat.id)
comment4 = Comment.create(content: "I had trouble with this lab, but here is a link that helped me out google.com", user_id:tricia.id)
comment5 = Comment.create(content: "nothing sticks, so i took a break", user_id:barbara.id)
comment6 = Comment.create(content: "this joke was super good!", user_id:karem.id)
comment7 = Comment.create(content: "this joke was super terrinle!", user_id:manon.id)

#create likes
#user_id, comment_id, joke_id, like_counter
likes1 = Like.create(like_counter: 20, joke_id: joke1.id)
likes2 = Like.create(like_counter: 4, joke_id: joke2.id)
likes3 = Like.create(like_counter: 2, joke_id: joke3.id)
likes4 = Like.create(like_counter: 90, joke_id: joke4.id)
likes5 = Like.create(like_counter: 30, joke_id: joke5.id)
likes6 = Like.create(like_counter: 17, joke_id: joke6.id)
likes7 = Like.create(like_counter: 500, joke_id: joke7.id)

#create minions
#user_id, minion_counter
minion1 = Minion.create(user_id:francisco.id, minion_counter:99)
minion2 = Minion.create(user_id:netaly.id, minion_counter:80982)
minion3 = Minion.create(user_id:donat.id, minion_counter:89)
minion4 = Minion.create(user_id:karem.id, minion_counter:9)
minion5 = Minion.create(user_id:barbara.id, minion_counter:999)

