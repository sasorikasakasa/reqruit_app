
p "create Users"

User.create!(
  email: "aaa@aaa",
  password: "aaaaaa",
  name: "aaa",
  self_introduction: "私はmasterなり",
)

1.upto(6){ |n|
  User.create!(
    email: "user#{n}@gmail.com",
    password: "0000000",
    name: "user#{n}",
    self_introduction: "私はuser#{n}です。",
    profile_image: open("#{Rails.root}/db/dummy_images/#{n}.jpg"),
  )
}

2.upto(7){ |n|
  Reaction.create!(
    to_user_id: 1,
    from_user_id: n,
    status: "like",
  )
}