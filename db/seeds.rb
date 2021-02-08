User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

user1 = User.first
user2 = User.second

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

user2.microposts.create!(name: "久松湯",
                        address: "東京都練馬区",
                        price: 900,
                        sauna: 1,
                        evaluate: 4)

users = User.all
user = User.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
