
p "create Users"

1.upto(6){ |n|
  User.create!(
    email: "user#{n}@gmail.com",
    password: "0000000",
    name: "user#{n}",
    self_introduction: "私はuser#{n}です。",
    profile_image: open("#{Rails.root}/db/dummy_images/#{n}.jpg"),
  )
}
