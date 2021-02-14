User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

User.create!(name:  "サンプルユーザー",
             email: "user@sample.com",
             password:              "foobar",
             password_confirmation: "foobar")

# 追加のユーザーをまとめて生成する
98.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+2}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

user1 = User.first
user2 = User.second
user3 = User.third

user1.microposts.create!(name: "極楽湯",
                        address: "埼玉県和光市",
                        price: 730,
                        sauna: 1,
                        evaluate: 4)

user1.microposts.create!(name: "なごみの湯",
                        address: "東京都杉並区",
                        price: 2000,
                        sauna: 1,
                        evaluate: 3)

user2.microposts.create!(name: "極楽湯",
                        address: "埼玉県和光市",
                        price: 730,
                        sauna: 1,
                        evaluate: 4)

user2.microposts.create!(name: "なごみの湯",
                        address: "東京都杉並区",
                        price: 2000,
                        sauna: 1,
                        evaluate: 3)

user3.microposts.create!(name: "久松湯",
                        address: "東京都練馬区",
                        price: 900,
                        sauna: 1,
                        evaluate: 4)

users = User.all
following = users[2..50]
followers = users[2..40]
following.each { |followed| user1.follow(followed) }
followers.each { |follower| follower.follow(user1) }
following.each { |followed| user2.follow(followed) }
followers.each { |follower| follower.follow(user2) }
