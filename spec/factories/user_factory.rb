Factory.define :user do |user|
  user.sequence(:email) { |n| "user-#{n}@example.com" }
  user.password               "password"
  user.password_confirmation  "password"
  user.after_create { |u| u.confirm! }
end