User.destroy_all
Review.destroy_all
Book.destroy_all

5.times do
    Book.create(
        title: Faker::Book.unique.title,
        author: Faker::Book.unique.author,
        genre: Faker::Book.unique.genre
    )
end

5.times do
    User.create(
        name: Faker::Name.unique.name,
        age: rand(18..100)
    )
end

Review.create(
    comment: Faker::Books::Lovecraft.sentence,
    rating: rand(0..10),
    user_id: 1,
    book_id: 1
)

Review.create(
    comment: Faker::Books::Lovecraft.paragraph,
    rating: rand(0..10),
    user_id: 2,
    book_id: 2
)

Review.create(
    comment: Faker::Books::Lovecraft.paragraph,
    rating: rand(0..10),
    user_id: 3,
    book_id: 3
)

Review.create(
    comment: Faker::Books::Lovecraft.paragraph,
    rating: rand(0..10),
    user_id: 4,
    book_id: 4
)

Review.create(
    comment: Faker::Books::Lovecraft.paragraph,
    rating: rand(0..10),
    user_id: 5,
    book_id: 5
)