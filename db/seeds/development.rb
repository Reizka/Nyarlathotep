# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(
  email:"renny@test.com",
  first_name:"renny",
  last_name:"test",
  password:"password",
  password_confirmation:"password",
  role: User.roles[:admin]
  )

User.create(
  email:"test@test.com",
  first_name:"bob",
  last_name:"test2",
  password:"password",
  password_confirmation:"password"
  )


Address.first_or_create!(
  street:"1234 test st",
  city:"test city",
  postcode:"12345",
  country:"test country",
  user: User.first
)

Address.first_or_create!(
  street:"4321 test st",
  city:"test city",
  postcode:"54321",
  country:"test country",
  user: User.second
)

articles = []
comments = []
#TODO use faker gem to generate random data ... look into faker gem

category = Category.first_or_create!(name:"Uncategorized", display_in_nav: true)
Category.first_or_create!(name:"Category 1", display_in_nav: false)
Category.first_or_create!(name:"Category 2", display_in_nav: true)
Category.first_or_create!(name:"Category 3", display_in_nav: true)

elapsed_time = Benchmark.measure do
  10.times do |x|
    puts "Creating article #{x+1}"
     article = Article.new(
      title:"Title #{x+1}",
      body:"#{x} lorem ipsum dorem....",
      status:"public",
      category: category,
      user_id: User.first.id)
      articles.push(article)

      10.times do |y|
        puts "Creating comment #{y+1} for article #{x+1} out of 100"
        comment = article.comments.new(
          body:"#{y} Comment ipsum dorem....",
          status:"public",
          user_id: User.second.id)
        comments.push(comment)
      end
  end
end
#uses gem actriverecord-import only works with postgresql
Article.import(articles)
Comment.import(comments)

puts "Seeded develompent DB #{articles.count} articles and #{comments.count} comments in #{elapsed_time.real} seconds"
